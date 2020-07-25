//
//  UseCasesIntegrationTests.swift
//  UseCasesIntegrationTests
//
//  Created by Felipe Ribeiro Mendes on 20/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Data
import Domain
import Infrastructure
import XCTest

class AddAccountIntegrationTests: XCTestCase {
    func test_add_account() {
        let url = URL(string: "http://localhost:8888/api/signup")!
        let alamofireAdapter = AlamofireAdapter()
        let sut = AddAccountUseCase(url: url, httpClient: alamofireAdapter)
        let newAccount = AccountRequest(name: "Name",
                                        email: "\(UUID().uuidString)@mail.com",
            password: "123456",
            passwordConfirmation: "123456")

        let exp = expectation(description: "waiting")
        sut.add(accountRequest: newAccount) { accountResponse in
            switch accountResponse {
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            case .failure:
                XCTFail("Expect success but received \(accountResponse) instead.")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 5)

        let exp2 = expectation(description: "waiting")
        sut.add(accountRequest: newAccount) { accountResponse in
            switch accountResponse {
            case .failure(let error) where error == .emailInUse:
                XCTAssertNotNil(error)
            default:
                XCTFail("Expect failure but received \(accountResponse) instead.")
            }
        }
        exp2.fulfill()
    }

    wait(for: [exp2], timeout: 5)
}
