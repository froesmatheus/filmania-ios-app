//
//  Errors.swift
//  filmania
//
//  Created by Matheus Fróes on 15/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct RuntimeError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}

struct APIError: Decodable, Error {
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
    }

    public var localizedDescription: String {
        return statusMessage
    }
}
