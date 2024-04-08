//
//  MarvelError.swift
//  RepositoryPattern
//
//  Created by 이성민 on 4/8/24.
//

import Foundation

enum MarvelError: Error {
    case decoding
    case server(message: String)
}
