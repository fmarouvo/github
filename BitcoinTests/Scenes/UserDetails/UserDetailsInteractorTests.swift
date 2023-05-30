//
//  UserDetailsInteractorTests.swift
//  BitcoinTests
//
//  Created by Fausto Marouvo on 30/05/23.
//

@testable import Bitcoin
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class UserDetailsInteractorTests: XCTestCase {
    private var sut: UserDetailsInteractor!
    private var disposeBag: DisposeBag!
    private let fetchUserDetailsUseCase: FetchUserDetailsUseCaseMock!
    private let fetchUserRepositoriesUseCase: FetchUserRepositoriesUseCaseMock!
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
            update_at: "2023-05-07T20:51:28Z",
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
        sut = HomeInteractor(
            fetchUserDetailsUseCase: fetchUserDetailsUseCase,
            fetchUserRepositoriesUseCase: fetchUserRepositoriesUseCase
        )
    }

    func test_shouldFetchUserDetails_success() {
        fetchUserDetailsUseCase.fetchUserDetailsReturnValue = Single.just(userDetailsResponseExpected)
        sut.fetchUserDetails()
            .subscribe(onSuccess: { _ in
                XCTAssert(true)
            })
            .disposed(by: disposeBag)
    }
}
