//
//  NBAResult.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

class NBAResult: SportResult {
    
    let gameNumber: Int
    let looser: String
    let mvp: String
    
    enum DecodingKeys: String, CodingKey {
        case gameNumber
        case looser
        case mvp
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        gameNumber = try container.decode(Int.self, forKey: .gameNumber)
        looser = try container.decode(String.self, forKey: .looser)
        mvp = try container.decode(String.self, forKey: .mvp)
        try super.init(from: decoder)
    }
    
    override func titleText() -> String {
        return "\(mvp) leads \(winner) to game \(gameNumber) win in the NBA playoffs"
    }
}
