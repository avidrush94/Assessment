//
//  MealResponse.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import Foundation

struct MealResponse: Decodable {
    let meals: [Meal]
    
    enum CodingKeys: CodingKey {
        case meals
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<MealResponse.CodingKeys> = try decoder.container(keyedBy: MealResponse.CodingKeys.self)
        
        if let meals = try container.decodeIfPresent([Meal].self, forKey: MealResponse.CodingKeys.meals) {
            self.meals = meals
        } else {
            self.meals = []
        }
    }
}
