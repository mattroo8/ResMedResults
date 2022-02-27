//
//  HTTPClient.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

protocol NetworkRequester {
    func makeNetworkRequest(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case unexpectedResponse
}

class HTTPClient: NetworkRequester {
    
    let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func makeNetworkRequest(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void){
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error  in
            
            if let error = error {
                print("Error \(error)")
                completion(.failure(.unexpectedResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.unexpectedResponse))
                return
            }
            
            completion(.success(data))
            return
            
        })
        task.resume()
    }

}
