//
//  APIClient.swift
//  RepositoryPattern
//
//  Created by 이성민 on 4/7/24.
//

import Foundation

typealias ResultCallBack<Value> = (Result<Value, Error>) -> Void

protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    /// Request method
    var method: HTTPMethod { get }
    /// Request endpoint (e.g. `/characters`)
    var resource: String { get }
}

protocol APIClient {
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping ResultCallBack<DataContainer<T.Response>>
    )
}

extension APIClient {
    func send<T: APIRequest>(
        _ request: T,
        completion: @escaping ResultCallBack<DataContainer<T.Response>>
    ) {
        let endpoint = endpoint(for: request)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    let marvelResponse = try JSONDecoder().decode(MarvelResponse<T.Response>.self, from: data)
                    
                    if let dataContainer = marvelResponse.data {
                        completion(.success(dataContainer))
                    } 
                    else if let message = marvelResponse.message {
                        completion(.failure(MarvelError.server(message: message)))
                    } 
                    else {
                        completion(.failure(MarvelError.decoding))
                    }
                } catch {
                    completion(.failure(error))
                }
            } 
            else if let error = error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func endpoint<T: APIRequest>(for request: T) -> URL {
        guard let baseURL = URL(string: request.resource, relativeTo: URL(string: "https://developer.marvel.com")) else {
            fatalError("Bad resource name: \(request.resource)")
        }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        // some common query items
        // custom query items
        let customQueryItems: [URLQueryItem]
        do {
            customQueryItems = try URLQueryItemEncoder.encode(request)
        } catch {
            fatalError("Wrong parameters: \(error)")
        }
        
        components.queryItems = customQueryItems
        
        return components.url!
    }
}
