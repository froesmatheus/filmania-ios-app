//
//  Extensions.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

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
