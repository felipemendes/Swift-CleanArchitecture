//
//  StoryboardProtocol.swift
//  UI
//
//  Created by Felipe Ribeiro Mendes on 16/07/20.
//  Copyright © 2020 Felipe Mendes. All rights reserved.
//

import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    public static func instantiate() -> Self {
        let viewControllerName = String(describing: self)
        let storyboardName = viewControllerName.components(separatedBy: "ViewController")[0]
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)

        // swiftlint:disable force_cast
        return storyboard.instantiateViewController(identifier: viewControllerName) as! Self
        // swiftlint:enable force_cast
    }
}
