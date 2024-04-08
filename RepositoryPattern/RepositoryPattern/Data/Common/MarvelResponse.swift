//
//  MarvelResponse.swift
//  RepositoryPattern
//
//  Created by 이성민 on 4/8/24.
//

import Foundation

struct MarvelResponse<Response: Decodable>: Decodable {
    let status: String?
    let message: String?
    let data: DataContainer<Response>?
}

struct DataContainer<Results: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let resulst: Results
}
