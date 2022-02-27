//
//  SportsResultsResponse.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

struct SportsResultsResponse: Decodable {
    
    let f1Results: [F1Result]
    let nbaResults: [NBAResult]
    let tennis: [TennisResult]
    
    enum DecodingKeys: String, CodingKey {
        case f1Results
        case nbaResults
        case Tennis
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        f1Results = try container.decode([F1Result].self, forKey: .f1Results)
        nbaResults = try container.decode([NBAResult].self, forKey: .nbaResults)
        tennis = try container.decode([TennisResult].self, forKey: .Tennis)
    }
    
    func listResults() -> [SportResult] {
        var results = [SportResult]()
        results.append(contentsOf: f1Results)
        results.append(contentsOf: nbaResults)
        results.append(contentsOf: tennis)
        results.sort(by: {$0.publicationDate > $1.publicationDate})
        return results
    }
}
