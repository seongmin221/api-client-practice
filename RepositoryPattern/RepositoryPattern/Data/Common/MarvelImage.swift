//
//  MarvelImage.swift
//  RepositoryPattern
//
//  Created by 이성민 on 4/8/24.
//

import Foundation

struct MarvelImage: Decodable {
    enum ImageKeys: String, CodingKey {
        case path = "path"
        case fileExtension = "extension"
    }
    
    let url: URL
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: ImageKeys.self)
        
        let path = try container.decode(String.self, forKey: .path)
        let fileExtension = try container.decode(String.self, forKey: .fileExtension)
        
        guard let url = URL(string: "\(path).\(fileExtension)") else { throw MarvelError.decoding }
        self.url = url
    }
}
