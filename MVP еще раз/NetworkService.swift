//
//  NetworkService.swift
//  MVP еще раз
//
//  Created by Eвгений Павлюков on 12.02.2023.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol: AnyObject {
    func getModelFromInternet(completion: @escaping (Result<RecepyModelArray?, Error>) -> Void)
    func getPhoto(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}


class NetworkService: NetworkServiceProtocol {
    
    func getModelFromInternet(completion: @escaping (Result<RecepyModelArray?, Error>) -> Void) {
        let number = "number=300&"
        let urlString = "https://api.spoonacular.com/recipes/random?\(number)apiKey=286e94bc02d443d5a5d4a1f7bc25cf6d"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode(RecepyModelArray?.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPhoto(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
