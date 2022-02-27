//
//  TennisResult.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

class TennisResult: SportResult {
    
    let numberOfSets: Int
    let looser: String
    
    enum DecodingKeys: String, CodingKey {
        case numberOfSets
        case looser
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        numberOfSets = try container.decode(Int.self, forKey: .numberOfSets)
        looser = try container.decode(String.self, forKey: .looser).trimmingCharacters(in: .whitespacesAndNewlines)
        try super.init(from: decoder)
    }
    
    override func titleText() -> String {
        return "\(tournament): \(winner) wins against \(looser) in \(numberOfSets) sets"
    }
}
