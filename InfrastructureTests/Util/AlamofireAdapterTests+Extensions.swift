//
//  AlamofireAdapterTests+Extensions.swift
//  InfrastructureTests
//
//  Created by Felipe Ribeiro Mendes on 13/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation
import Alamofire

extension AlamofireAdapterTests {
    func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)

        return AlamofireAdapter(session: session)
    }
}
