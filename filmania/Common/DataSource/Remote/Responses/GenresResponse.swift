//
//  GenresResponse.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genre]
}
