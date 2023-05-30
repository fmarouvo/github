//
//  UserListViewModelTests.swift
//  GithubTests
//
//  Created by Fausto Marouvo on 30/05/23.
//

@testable import Fausto_Teste
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class UserListViewModelTests: XCTestCase {
    private var sut: UserListViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: UserListInteractableMock!

    private var error: TestableObserver<Error>!
    private var isLoading: TestableObserver<Bool>!
    private var onUserListFetched: TestableObserver<[UserResponse]>!
    private var userResponseExpected: [UserResponse]!

    override func setUp() {
        super.setUp()
        setupUserListViewModel()
    }

    private func setupUserListViewModel() {
        disposeBag = DisposeBag()
        interactor = UserListInteractableMock()
        sut = UserListViewModel(interactor: interactor)

        userResponseExpected = [UserResponse(
            login: "login",
            id: 1,
            avatar_url: "https://github.com/user/avatar"
        )]

        let testScheduler = TestScheduler(initialClock: 0)

        error = testScheduler.createObserver(Error.self)
        sut.output.error.drive(error).disposed(by: disposeBag)

        isLoading = testScheduler.createObserver(Bool.self)
        sut.output.isLoading.drive(isLoading).disposed(by: disposeBag)

        onUserListFetched = testScheduler.createObserver([UserResponse].self)
        sut.output.onUserListFetched.drive(onUserListFetched).disposed(by: disposeBag)

        testScheduler.start()
    }

    func testShouldEmit_Error_When_FetchData() {
        let customError = NSError(domain: "", code: 0, userInfo: nil)

        interactor.fetchUserListReturnValue = .error(customError)

        sut.input.fetchUserList.onNext(())

        XCTAssertEqual(
            error.events.compactMap { $0.value.element } as [NSError],
            [customError]
        )
    }

    func testShouldEmit_IsLoading_When_FetchData() {
        interactor.fetchUserListReturnValue = .just(userResponseExpected)

        sut.input.fetchUserList.onNext(())

        XCTAssertEqual(
            isLoading.events.compactMap { $0.value.element },
            [false, true, false]
        )
    }

    func testShouldEmit_fetchUserList_success() {
        interactor.fetchUserListReturnValue = .just(userResponseExpected)

        sut.input.fetchUserList.onNext(())

        XCTAssertEqual(
            onUserListFetched.events.compactMap { $0.value.element }.count,
            1
        )
    }
}
