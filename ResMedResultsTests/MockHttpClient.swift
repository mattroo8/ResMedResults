//
//  MockHttpClient.swift
//  ResMedResultsTests
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

@testable import ResMedResults

class MockHTTPClient: NetworkRequester {
    
    func makeNetworkRequest(with request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: "MockResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(.success(data))
              } catch {
                   print("Could not read mock response")
              }
        } else {
            print("Could not find file")
        }
    }

}
