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

//MARK: - fetchUserDetails

var fetchUserDetailsLoginCallsCount = 0
var fetchUserDetailsLoginCalled: Bool {
return fetchUserDetailsLoginCallsCount > 0
}
var fetchUserDetailsLoginReceivedLogin: String?
var fetchUserDetailsLoginReturnValue: Single<UserDetailsResponse>!
var fetchUserDetailsLoginClosure: ((String) -> Single<UserDetailsResponse>)?

func fetchUserDetails(login: String) -> Single<UserDetailsResponse> {
fetchUserDetailsLoginCallsCount += 1
fetchUserDetailsLoginReceivedLogin = login
return fetchUserDetailsLoginClosure.map({ $0(login) }) ?? fetchUserDetailsLoginReturnValue
}

}
class FetchUserListUseCaseMock: FetchUserListUseCase {

//MARK: - fetchUserList

var fetchUserListCallsCount = 0
var fetchUserListCalled: Bool {
return fetchUserListCallsCount > 0
}
var fetchUserListReturnValue: Single<[UserResponse]>!
var fetchUserListClosure: (() -> Single<[UserResponse]>)?

func fetchUserList() -> Single<[UserResponse]> {
fetchUserListCallsCount += 1
return fetchUserListClosure.map({ $0() }) ?? fetchUserListReturnValue
}

}
class FetchUserRepositoriesUseCaseMock: FetchUserRepositoriesUseCase {

//MARK: - fetchUserRepositories

var fetchUserRepositoriesLoginCallsCount = 0
var fetchUserRepositoriesLoginCalled: Bool {
return fetchUserRepositoriesLoginCallsCount > 0
}
var fetchUserRepositoriesLoginReceivedLogin: String?
var fetchUserRepositoriesLoginReturnValue: Single<[UserRepositoriesResponse]>!
var fetchUserRepositoriesLoginClosure: ((String) -> Single<[UserRepositoriesResponse]>)?

func fetchUserRepositories(login: String) -> Single<[UserRepositoriesResponse]> {
fetchUserRepositoriesLoginCallsCount += 1
fetchUserRepositoriesLoginReceivedLogin = login
return fetchUserRepositoriesLoginClosure.map({ $0(login) }) ?? fetchUserRepositoriesLoginReturnValue
}

}
class UserDetailsInteractableMock: UserDetailsInteractable {

//MARK: - fetchUserDetails

var fetchUserDetailsLoginCallsCount = 0
var fetchUserDetailsLoginCalled: Bool {
return fetchUserDetailsLoginCallsCount > 0
}
var fetchUserDetailsLoginReceivedLogin: String?
var fetchUserDetailsLoginReturnValue: Single<UserDetailsResponse>!
var fetchUserDetailsLoginClosure: ((String) -> Single<UserDetailsResponse>)?

func fetchUserDetails(login: String) -> Single<UserDetailsResponse> {
fetchUserDetailsLoginCallsCount += 1
fetchUserDetailsLoginReceivedLogin = login
return fetchUserDetailsLoginClosure.map({ $0(login) }) ?? fetchUserDetailsLoginReturnValue
}

//MARK: - fetchUserRepositories

var fetchUserRepositoriesLoginCallsCount = 0
var fetchUserRepositoriesLoginCalled: Bool {
return fetchUserRepositoriesLoginCallsCount > 0
}
var fetchUserRepositoriesLoginReceivedLogin: String?
var fetchUserRepositoriesLoginReturnValue: Single<[UserRepositoriesResponse]>!
var fetchUserRepositoriesLoginClosure: ((String) -> Single<[UserRepositoriesResponse]>)?

func fetchUserRepositories(login: String) -> Single<[UserRepositoriesResponse]> {
fetchUserRepositoriesLoginCallsCount += 1
fetchUserRepositoriesLoginReceivedLogin = login
return fetchUserRepositoriesLoginClosure.map({ $0(login) }) ?? fetchUserRepositoriesLoginReturnValue
}

}
class UserListInteractableMock: UserListInteractable {

//MARK: - fetchUserList

var fetchUserListCallsCount = 0
var fetchUserListCalled: Bool {
return fetchUserListCallsCount > 0
}
var fetchUserListReturnValue: Single<[UserResponse]>!
var fetchUserListClosure: (() -> Single<[UserResponse]>)?

func fetchUserList() -> Single<[UserResponse]> {
fetchUserListCallsCount += 1
return fetchUserListClosure.map({ $0() }) ?? fetchUserListReturnValue
}

}
