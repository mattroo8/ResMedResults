//
//  Result.swift
//  ResMedResults
//
//  Created by matt rooney on 27/02/2022.
//

import Foundation

class SportResult: Decodable {
    let publicationDate: Date
    let tournament: String
    let winner: String
    
    enum DecodingKeys: String, CodingKey {
        case publicationDate
        case tournament
        case winner
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        publicationDate = try container.decode(Date.self, forKey: .publicationDate)
        tournament = try container.decode(String.self, forKey: .tournament).trimmingCharacters(in: .whitespacesAndNewlines)
        winner = try container.decode(String.self, forKey: .winner).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func titleText() -> String {
        return "\(tournament): \(winner) wins"
    }
}
