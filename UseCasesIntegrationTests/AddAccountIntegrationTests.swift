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
        let sut = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let newAccount = AccountRequest(name: "Name",
                                        email: "name@mail.com",
                                        password: "123",
                                        passwordConfirmation: "123456")

        let exp = expectation(description: "waiting")
        sut.add(accountRequest: newAccount) { accountResponse in
            switch accountResponse {
            case .success(let account):
                XCTAssertNotNil(account.identifier)
                XCTAssertEqual(account.name, newAccount.name)
                XCTAssertEqual(account.email, newAccount.email)
            case .failure:
                XCTFail("Expect success but received \(accountResponse) instead.")
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 5)
    }
}
