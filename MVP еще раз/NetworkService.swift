//
//  NetworkService.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation

protocol networkServiceProtocol {
    func getModelFromInternet(completion: @escaping (Result<[CellModel]?, Error>) -> Void)
}


class NetworkService: networkServiceProtocol {
    
    func getModelFromInternet(completion: @escaping (Result<[CellModel]?, Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode([CellModel].self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
