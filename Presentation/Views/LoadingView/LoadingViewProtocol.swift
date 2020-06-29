//
//  LoadingViewProtocol.swift
//  Presentation
//
//  Created by Felipe Ribeiro Mendes on 28/06/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import Foundation

public protocol LoadingViewProtocol {
    //var isLoading: Bool { get }

    func display(loadingViewModel: LoadingViewModel)
}
