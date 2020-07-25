//
//  LoadingViewModel.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 28/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public struct LoadingViewModel: Equatable {

    public var isLoading: Bool

    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}
