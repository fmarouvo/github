//
//  UserDetailsViewModelTests.swift
//  GithubTests
//
//  Created by Fausto Marouvo on 30/05/23.
//

@testable import Fausto_GitHub
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class UserDetailsViewModelTests: XCTestCase {
    private var sut: UserDetailsViewModel!
    private var disposeBag: DisposeBag!
    private var interactor: UserDetailsInteractableMock!

    private var error: TestableObserver<Error>!
    private var isLoading: TestableObserver<Bool>!
    private var onUserDetailsFetched: TestableObserver<UserDetailsResponse>!
    private var onUserRepositoriesFetched: TestableObserver<[UserRepositoriesResponse]>!
    private var userDetailsResponseExpected: UserDetailsResponse!
    private var userRepositoriesResponseExpected: [UserRepositoriesResponse]!

    override func setUp() {
        super.setUp()
        setupUserDetailsViewModel()
    }

    private func setupUserDetailsViewModel() {
        disposeBag = DisposeBag()
        interactor = UserDetailsInteractableMock()
        sut = UserDetailsViewModel(interactor: interactor)

        userDetailsResponseExpected = UserDetailsResponse(
            login: "login",
            id: 1,
            avatar_url: "https://github.com/login/avatar",
            company: "company",
            location: "location"
        )

        userRepositoriesResponseExpected = [UserRepositoriesResponse(
            name: "name",
            description: "description",
            updated_at: "2023-05-07T20:51:28Z",
            watchers: 12
        )]

        let testScheduler = TestScheduler(initialClock: 0)

        error = testScheduler.createObserver(Error.self)
        sut.output.error.drive(error).disposed(by: disposeBag)

        isLoading = testScheduler.createObserver(Bool.self)
        sut.output.isLoading.drive(isLoading).disposed(by: disposeBag)

        onUserDetailsFetched = testScheduler.createObserver(UserDetailsResponse.self)
        sut.output.onUserDetailsFetched.drive(onUserDetailsFetched).disposed(by: disposeBag)

        onUserRepositoriesFetched = testScheduler.createObserver([UserRepositoriesResponse].self)
        sut.output.onUserRepositoriesFetched.drive(onUserRepositoriesFetched).disposed(by: disposeBag)

        testScheduler.start()
    }

    func testShouldEmit_Error_When_FetchData() {
        let customError = NSError(domain: "", code: 0, userInfo: nil)

        interactor.fetchUserDetailsLoginReturnValue = .error(customError)

        sut.input.fetchUserDetails.onNext("log")

        XCTAssertEqual(
            error.events.compactMap { $0.value.element } as [NSError],
            [customError]
        )
    }

    func testShouldEmit_IsLoading_When_FetchData() {
        interactor.fetchUserDetailsLoginReturnValue = .just(userDetailsResponseExpected)

        sut.input.fetchUserDetails.onNext("login")

        XCTAssertEqual(
            isLoading.events.compactMap { $0.value.element },
            [false, false, true, false]
        )
    }

    func testShouldEmit_fetchUserDetails_success() {
        interactor.fetchUserDetailsLoginReturnValue = .just(userDetailsResponseExpected)

        sut.input.fetchUserDetails.onNext("login")

        XCTAssertEqual(
            onUserDetailsFetched.events.compactMap { $0.value.element }.count,
            1
        )
    }

    func testShouldEmit_fetchUserRepositories_success() {
        interactor.fetchUserRepositoriesLoginReturnValue = .just(userRepositoriesResponseExpected)

        sut.input.fetchUserRepositories.onNext("login")

        XCTAssertEqual(
            onUserRepositoriesFetched.events.compactMap { $0.value.element }.count,
            1
        )
    }
}
