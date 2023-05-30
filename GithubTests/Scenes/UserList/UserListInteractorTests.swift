//
//  UserListInteractorTests.swift
//  GithubTests
//
//  Created by Fausto Marouvo on 30/05/23.
//

@testable import Fausto_Teste
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class UserListInteractorTests: XCTestCase {
    private var sut: UserListInteractor!
    private var disposeBag: DisposeBag!
    private var fetchUserListUseCase: FetchUserListUseCaseMock!
    private var userResponseExpected: [UserResponse]!

    override func setUp() {
        super.setUp()
        setupUserListInteractor()
        userResponseExpected = [UserResponse(
            login: "login",
            id: 1,
            avatar_url: "https://github.com/user/avatar"
        )]
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupUserListInteractor() {
        disposeBag = DisposeBag()
        fetchUserListUseCase = FetchUserListUseCaseMock()
        sut = UserListInteractor(
            fetchUserListUseCase: fetchUserListUseCase
        )
    }

    func test_shouldFetchUserList() {
        fetchUserListUseCase.fetchUserListReturnValue = Single.just(userResponseExpected)
        sut.fetchUserList()
            .subscribe(onSuccess: { value in
                XCTAssertEqual(value, self.userResponseExpected)
            })
            .disposed(by: disposeBag)
    }
}
