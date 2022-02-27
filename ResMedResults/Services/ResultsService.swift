//
//  ResultsService.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

class ResultsService {
    
    let httpClient: HTTPClient
    
    init(_ client: HTTPClient = HTTPClient()) {
        self.httpClient = client
    }
    
    func getResults(completion: @escaping (Result<SportsResultsResponse, Error>) -> Void){
        let url = URL(string: "https://ancient-wood-1161.getsandbox.com/results")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        httpClient.makeNetworkRequest(with: urlRequest, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(Date.formatter())
                        let sportsResults = try decoder.decode(SportsResultsResponse.self, from: result)
                        completion(.success(sportsResults))
                    } catch let error {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        })
        
    }
    
}
