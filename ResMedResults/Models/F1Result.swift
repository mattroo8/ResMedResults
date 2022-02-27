//
//  F1Result.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

class F1Result: SportResult {
    
    let seconds: Double
    
    enum DecodingKeys: String, CodingKey {
        case seconds
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        seconds = try container.decode(Double.self, forKey: .seconds)
        try super.init(from: decoder)
    }
    
    override func titleText() -> String {
        return "\(winner) wins \(tournament) by \(seconds) seconds"
    }
}
