//
//  NetworkService.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import Foundation


enum NetworkServiceError: Error {
    case connectionError(String)
    case dataIsNilError
    case decodingFailure(String)
}

protocol NetworkServiceProtocol {
    func fetchComments(completion: @escaping (Result<[Comment]?, NetworkServiceError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetchComments(completion: @escaping (Result<[Comment]?, NetworkServiceError>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.connectionError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataIsNilError))
                return
            }

            do {
                let comments = try JSONDecoder().decode([Comment].self, from: data)
                completion(.success(comments))
            } catch {
                completion(.failure(.decodingFailure(error.localizedDescription)))
            }
        }.resume()
    }
}
