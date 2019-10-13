//
//  NetworkService.swift
//  ListOfUsers
//
//  Created by Александр Алгашев on 18/09/2019.
//  Copyright © 2019 Александр Алгашев. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol: class {
    func getUsersFromJSON(completion: @escaping ([User]) -> ())
}

class NetworkService: NetworkServiceProtocol {
    private init() { }
    static let shared = NetworkService()
    
    private let sharedSession = URLSession.shared
    private var dataTask: URLSessionDataTask?
    private let url = AppSettings.sourceUrl
    
    func getUsersFromJSON(completion: @escaping ([User]) -> ()) {
        self.dataTask?.cancel()
        guard let url = URL(string: url) else { return }
        dataTask = self.sharedSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let error = error {
                print(error)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let users = try decoder.decode([User].self, from: data)
                    DispatchQueue.main.async {
                        completion(users)
                    }
                } catch {
                    print(error)
                    return
                }
            }
        }
        dataTask?.resume()
    }
}
