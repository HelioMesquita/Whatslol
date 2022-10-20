//
//  NetworkService.swift
//  Whatslol
//
//  Created by Hélio Mesquita on 18/10/22.
//

import Foundation

protocol NetworkServiceProtocol {
    func performRequest<X: Decodable>(url: URL,
                                     responseModel: X.Type,
                                     onSuccess: @escaping (X) -> Void,
                                     onFailure: @escaping (Error) -> ())
}

class NetworkService: NetworkServiceProtocol {
    
    func performRequest<X: Decodable>(url: URL,
                                     responseModel: X.Type,
                                     onSuccess: @escaping (X) -> Void,
                                     onFailure: @escaping (Error) -> ()
    ){
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                let decodeObject = try JSONDecoder().decode(X.self, from: data ?? Data())
                DispatchQueue.main.async {
                    onSuccess(decodeObject)
                }
            } catch {
                onFailure(error)
            }
            
        }.resume()
    }
}
