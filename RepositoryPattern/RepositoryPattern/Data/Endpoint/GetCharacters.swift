//
//  GetCharacters.swift
//  RepositoryPattern
//
//  Created by 이성민 on 4/8/24.
//

import Foundation

struct GetCharacters: APIRequest {
    // MARK: - API Request protocol을 따르기 위한 요소들
    typealias Response = [ComicCharacter]
    
    // Computed Property로 설정한 이유는 Encodable에서 무시되기 때문
    // 따라서 해당 property들은 parameter로 encoding 되지 않음
    
    var method: HTTPMethod { .get }
    var resource: String { "characters" }
    
    // MARK: - 실제 request 내용들
    let name: String?
    let nameStartsWith: String?
    let limit: Int?
    let offset: Int?
    
    init(
        name: String? = nil,
        nameStartsWith: String? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) {
        self.name = name
        self.nameStartsWith = nameStartsWith
        self.limit = limit
        self.offset = offset
    }
}

struct ComicCharacter: Decodable {
    // id가 optional이 아닌 이유
    // 잘못된 character가 response로 오면, 에러처리할 수 있음
    let id: Int
    let name: String?
    let description: String?
    let thumbnail: MarvelImage?
}
