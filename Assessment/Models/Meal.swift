//
//  Meal.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import Foundation

public class Meal: Decodable {
    public let id: String
    public let name: String
    public let drinkAlternate: String?
    public let category: String?
    public let area: String?
    public let instructions: String?
    public let thumbnail: String?
    public let tags: String?
    public let youtube: String?
    public let ingredients: [String]
    public let measures: [String]
    public let source: String?
    public let imageSource: String?
    public let creativeCommonsConfirmed: String?
    public let dateModified: String?
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        
        case strIngredient
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        
        case strMeasure
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
        
        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
    }
    
    required public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Meal.CodingKeys> = try decoder.container(keyedBy: Meal.CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: Meal.CodingKeys.idMeal)
        self.name = try container.decode(String.self, forKey: Meal.CodingKeys.strMeal)
        self.drinkAlternate = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strDrinkAlternate)
        self.category = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strCategory)
        self.area = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strArea)
        self.instructions = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strInstructions)
        self.thumbnail = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strMealThumb)
        self.tags = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strTags)
        self.youtube = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strYoutube)
        
        var ingredients: [String] = []
        for each in 1...20 {
            if let key = Meal.CodingKeys.init(rawValue: Meal.CodingKeys.strIngredient.rawValue + "\(each)"),
               let ingredient = try? container.decodeIfPresent(String.self, forKey: key),
               !ingredient.isEmpty {
                ingredients.append(ingredient)
            }
        }
        self.ingredients = ingredients
        
        var measures: [String] = []
        for each in 1...20 {
            if let key = Meal.CodingKeys.init(rawValue: Meal.CodingKeys.strMeasure.rawValue + "\(each)"),
               let measure = try? container.decodeIfPresent(String.self, forKey: key),
               !measure.isEmpty {
                measures.append(measure)
            }
        }
        self.measures = measures
        
        self.source = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strSource)
        self.imageSource = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strImageSource)
        self.creativeCommonsConfirmed = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.strCreativeCommonsConfirmed)
        self.dateModified = try container.decodeIfPresent(String.self, forKey: Meal.CodingKeys.dateModified)
        
    }
    
}

extension Meal: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(drinkAlternate)
        hasher.combine(category)
        hasher.combine(area)
        hasher.combine(instructions)
        hasher.combine(thumbnail)
        hasher.combine(tags)
        hasher.combine(youtube)
        hasher.combine(ingredients)
        hasher.combine(measures)
        hasher.combine(source)
        hasher.combine(imageSource)
        hasher.combine(creativeCommonsConfirmed)
        hasher.combine(dateModified)
    }
}

extension Meal: Identifiable {}

extension Meal: Equatable {
    static public func == (_ lhs: Meal, _ rhs: Meal) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
