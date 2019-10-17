//
//  Extensions.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func toString(usingFormat format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func toDate(usingFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

public protocol Storyboarded {
    static func instantiate(fromStoryboard storyboard: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    public static func instantiate(fromStoryboard storyboard: String) -> Self {
        let viewControllerIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)

        if let controller = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier) as? Self {
            return controller
        } else {
            fatalError("Could not instantiate viewcontroller with identifier \"\(viewControllerIdentifier)\"")
        }
    }
}

extension UIViewController: Storyboarded {}
