//
//  Errors.swift
//  filmania
//
//  Created by Matheus Fróes on 15/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct RuntimeError: LocalizedError {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    var errorDescription: String? {
        return message
    }
}

struct APIError: Decodable, LocalizedError {
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
    }

    var errorDescription: String? {
        return statusMessage
    }
}
