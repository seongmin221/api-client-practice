//
//  HTTPParameter.swift
//  RepositoryPattern
//
//  Created by 이성민 on 4/8/24.
//

import Foundation

enum HTTPParameter: Decodable {
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let string = try? container.decode(String.self) {
            self = .string(string)
        } 
        else if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        }
        else if let int = try? container.decode(Int.self) {
            self = .int(int)
        }
        else if let double = try? container.decode(Double.self) {
            self = .double(double)
        }
        else {
            throw MarvelError.decoding
        }
    }
    
    var description: String {
        switch self {
        case .string(let string): return string
        case .bool(let bool): return bool.description
        case .int(let int): return int.description
        case .double(let double): return double.description
        }
    }
}
