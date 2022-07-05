//
//  NetworkManager.swift
//  PostsFeed
//
//  Created by user on 03.07.2022.
//

import Foundation

enum HTTPMethod: String {
    
    case get = "GET"
}

protocol HTTPRequest {
    
    var url: String { get }
    var method: HTTPMethod { get }
}

enum ApiEndpoint {
    
    case getFeed
    case getPost(id: Int)
}

extension ApiEndpoint: HTTPRequest {
    
    var url: String {
        switch self {
        case .getFeed:
            let baseURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
            return baseURL
        case .getPost(let id):
            let baseURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts"
            let path = "/\(id).json"
            return baseURL + path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getFeed:
            return .get
        case .getPost(_):
            return .get
        }
    }
}

final class NetworkManager {
    
    private init() {}
    
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(from endpoint: ApiEndpoint, completed: @escaping (Result<T, ErrorMessage>) -> Void) {
        // Create URL
        guard let url = URL(string: endpoint.url) else {
            completed(.failure(.unableToComplete))
            return
        }
        
        // Get data
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completed(.success(decodedData))
            } catch {
                print("Error catched \(error)")
                completed(.failure(.invalidData))
            }
        }

        task.resume()
    }
}
