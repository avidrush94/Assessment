//
//  MealService.swift
//  Assessment
//
//  Created by Rushit on 13/08/23.
//

import Foundation
import Alamofire

final class MealService {
    
    // MARK: - Properties
    
    static private let baseURL: String = "https://www.themealdb.com/api/json/v1/1/"

    // MARK: - Services
    
    @discardableResult
    static func fetchMeals(
        startingWith searchString: String,
        onCompletion: @escaping (_ result: Result<[Meal], Error>) -> Void
    ) -> DataRequest {
        let sanitizedString = searchString.trimmingCharacters(in: .whitespacesAndNewlines)
        return AF.request("\(Self.baseURL)search.php?f=\(sanitizedString)")
            .responseDecodable { (response: DataResponse<MealResponse, AFError>) in
                switch response.result {
                case .success(let mealResponse):
                    onCompletion(.success(mealResponse.meals))
                    
                case .failure(AFError.explicitlyCancelled): break
                    
                case .failure(let error):
                    onCompletion(.failure(error))
                }
            }
    }
    
    @discardableResult
    static func fetchMealDetails(
        with id: Meal.ID,
        onCompletion: @escaping (_ result: Result<Meal, Error>) -> Void
    ) -> DataRequest {
        return AF.request("\(Self.baseURL)lookup.php?i=\(id)")
            .responseDecodable { (response: DataResponse<MealResponse, AFError>) in
                switch response.result {
                case .success(let mealResponse):
                    if let meal = mealResponse.meals.first {
                        onCompletion(.success(meal))
                    } else {
                        onCompletion(.failure(MealServiceError.mealNotFound))
                    }
                    
                case .failure(let error):
                    onCompletion(.failure(error))
                }
            }

    }
    
}

enum MealServiceError: Error {
    case mealNotFound
}

extension MealServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .mealNotFound: return "Unable to find the meal you are looking for. Please select some other meal."
        }
    }
}
