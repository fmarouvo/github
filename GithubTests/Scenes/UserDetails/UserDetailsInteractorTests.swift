//
//  UserDetailsInteractorTests.swift
//  GithubTests
//
//  Created by Fausto Marouvo on 30/05/23.
//

@testable import Fausto_Teste
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class UserDetailsInteractorTests: XCTestCase {
    private var sut: UserDetailsInteractor!
    private var disposeBag: DisposeBag!
    private var fetchUserDetailsUseCase: FetchUserDetailsUseCaseMock!
    private var fetchUserRepositoriesUseCase: FetchUserRepositoriesUseCaseMock!
    private var userDetailsResponseExpected: UserDetailsResponse!
    private var userRepositoriesResponseExpected: UserRepositoriesResponse!

    override func setUp() {
        super.setUp()
        setupHomeInteractor()
        let date = Date()
        let price = 10.0
        userDetailsResponseExpected = UserDetailsResponse(
            login: "login",
            id: 1,
            avatar_url: "https://github.com/login/avatar",
            company: "company",
            location: "location"
        )
        userRepositoriesResponseExpected = UserRepositoriesResponse(
            name: "name",
            description: "description",
            updated_at: "2023-05-07T20:51:28Z",
            watchers: 12
        )
    }

    override func tearDown() {
        super.tearDown()
    }

    private func setupHomeInteractor() {
        disposeBag = DisposeBag()
        fetchUserDetailsUseCase = FetchUserDetailsUseCaseMock()
        fetchUserRepositoriesUseCase = FetchUserRepositoriesUseCaseMock()
        sut = UserDetailsInteractor(
            fetchUserDetailsUseCase: fetchUserDetailsUseCase,
            fetchUserRepositoriesUseCase: fetchUserRepositoriesUseCase
        )
    }

    func test_shouldFetchUserDetails_success() {
        fetchUserDetailsUseCase.fetchUserDetailsLoginReturnValue = Single.just(userDetailsResponseExpected)
        sut.fetchUserDetails(login: userDetailsResponseExpected.login)
            .subscribe(onSuccess: { _ in
                XCTAssert(true)
            })
            .disposed(by: disposeBag)
    }
}
