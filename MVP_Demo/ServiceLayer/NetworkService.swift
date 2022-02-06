//
//  NetworkService.swift
//  MVP_Demo
//
//  Created by Artem Vaniukov on 06.02.2022.
//

import Foundation


protocol NetworkServiceProtocol {
    func fetchComments(completion: @escaping (Result<[Comment]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetchComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [:])))
                return
            }

            do {
                let comments = try JSONDecoder().decode([Comment].self, from: data)
                completion(.success(comments))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
