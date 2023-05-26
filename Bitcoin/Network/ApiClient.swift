//
//  ApiClient.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/19/20.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

enum ApiError: Error {
    case noInternetConnection
    case errorDomain
    case unknown
    case http(Error)
    case decodable(Error)
    case serverError(code: Int)
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return NSLocalizedString("Sem conexão", comment: "")
        case .errorDomain:
            return NSLocalizedString("Não encontrado", comment: "")
        case .unknown:
            return NSLocalizedString("Ocorreu um erro", comment: "")
        case .http(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        case .decodable(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        case .serverError(let code):
            return "Código do erro: \(code)"
        }
    }
}

protocol RouterType: URLRequestConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
    var contentType: String { get }
    var paramsArray: [[String: Any]]? { get }
    var paramsQueryString: [String: Any]? { get }
}

extension RouterType {
    var baseURL: URL {
        return URL(string: "https://api.blockchain.info/")!
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        if paramsQueryString != nil {
            return URLEncoding.queryString
        }
        return JSONEncoding.default
    }
    
    var contentType: String {
        return "application/json"
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = baseURL.appendingPathComponent(path)
        if path.contains("http") {
            url = URL(string: path)!
        }
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")

        
        if paramsQueryString != nil {
            urlRequest = try encoding.encode(urlRequest, with: paramsQueryString)
        }
        
        return try encoding.encode(urlRequest, with: params)
    }
}

final class ApiClient {
    private let session: Session
    private let successCode: Int = 200
    private let emptyDataStatusCodes: Set<Int> = [201, 204, 205]
    private let serverErrorStatusCodes = 500...599
    
    init(session: Session = Session.default) {
        self.session = session
    }

    func request(_ route: RouterType) -> Single<Data> {
        return Single.create { observer in
            let request = self.session
                .request(route)
                .validate()
                .responseData { response in
                    self.reponseLogging(response)
                    switch response.result {
                    case .success(let value):
                        do {
                            observer(.success(value))
                        }
                    case .failure(let error):
                        observer(.failure(self.onError(error, response: response)))
                    }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func requestSingle<T: Decodable>(_ route: RouterType, type: T.Type) -> Single<T> {
        return Single.create { observer in
            let request = self.session
                .request(route)
                .validate()
                .responseData { response in
                    self.reponseLogging(response)
                    print(response)
                    switch response.result {
                    case .success(let value):
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(T.self, from: value)
                            observer(.success(result))
                        } catch {
                            observer(.failure(self.onError(error, response: response)))
                        }
                    case .failure(let error):
                        observer(.failure(self.onError(error, response: response)))
                    }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }

    private func reponseLogging(_ response: AFDataResponse<Data>) {
        if let aaa = response.request, let body = aaa.httpBody {
            print("Request Parameters: \(String(describing: String(data: body, encoding: .utf8)))")
        }
        
        print("Request: \(String(describing: response.request))")
        print("Response: \(String(describing: response.response))")
        print("Error: \(String(describing: response.error))")
        
        if let data = response.data,
            let dict = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("Data Parsed:\n \(String(data: try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted), encoding: .utf8)!)")
        }
    }

    private func onError(_ error: Error, response: AFDataResponse<Data>) -> Error {

        if let httpResponse = response.response,
            serverErrorStatusCodes ~= httpResponse.statusCode {
            return ApiError.serverError(code: httpResponse.statusCode)
        }

        if (error as NSError).code == NSURLErrorNotConnectedToInternet {
            return ApiError.noInternetConnection
        }
        
        if (error as NSError).code == NSURLErrorCannotFindHost {
            return ApiError.errorDomain
        }

        return ApiError.http(error)
    }
}
