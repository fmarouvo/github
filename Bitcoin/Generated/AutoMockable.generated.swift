// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import Foundation
import CoreLocation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

import RxSwift














class FetchUserDetailsUseCaseMock: FetchUserDetailsUseCase {

//MARK: - fetchUserListUseCase

var fetchUserListUseCaseLoginCallsCount = 0
var fetchUserListUseCaseLoginCalled: Bool {
return fetchUserListUseCaseLoginCallsCount > 0
}
var fetchUserListUseCaseLoginReceivedLogin: String?
var fetchUserListUseCaseLoginReturnValue: Single<UserDetailsResponse>!
var fetchUserListUseCaseLoginClosure: ((String) -> Single<UserDetailsResponse>)?

func fetchUserListUseCase(login: String) -> Single<UserDetailsResponse> {
fetchUserListUseCaseLoginCallsCount += 1
fetchUserListUseCaseLoginReceivedLogin = login
return fetchUserListUseCaseLoginClosure.map({ $0(login) }) ?? fetchUserListUseCaseLoginReturnValue
}

}
class FetchUserListUseCaseMock: FetchUserListUseCase {

//MARK: - fetchUserListUseCase

var fetchUserListUseCaseCallsCount = 0
var fetchUserListUseCaseCalled: Bool {
return fetchUserListUseCaseCallsCount > 0
}
var fetchUserListUseCaseReturnValue: Single<UserListResponse>!
var fetchUserListUseCaseClosure: (() -> Single<UserListResponse>)?

func fetchUserListUseCase() -> Single<UserListResponse> {
fetchUserListUseCaseCallsCount += 1
return fetchUserListUseCaseClosure.map({ $0() }) ?? fetchUserListUseCaseReturnValue
}

}
class UserDetailsInteractableMock: UserDetailsInteractable {

}
class UserListInteractableMock: UserListInteractable {

}
class UserRepositoriesUseCaseMock: UserRepositoriesUseCase {

//MARK: - fetchUserListUseCase

var fetchUserListUseCaseLoginCallsCount = 0
var fetchUserListUseCaseLoginCalled: Bool {
return fetchUserListUseCaseLoginCallsCount > 0
}
var fetchUserListUseCaseLoginReceivedLogin: String?
var fetchUserListUseCaseLoginReturnValue: Single<UserRepositoriesResponse>!
var fetchUserListUseCaseLoginClosure: ((String) -> Single<UserRepositoriesResponse>)?

func fetchUserListUseCase(login: String) -> Single<UserRepositoriesResponse> {
fetchUserListUseCaseLoginCallsCount += 1
fetchUserListUseCaseLoginReceivedLogin = login
return fetchUserListUseCaseLoginClosure.map({ $0(login) }) ?? fetchUserListUseCaseLoginReturnValue
}

}
