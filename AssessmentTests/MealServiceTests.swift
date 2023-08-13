//
//  MealServiceTests.swift
//  AssessmentTests
//
//  Created by Rushit on 13/08/23.
//

import XCTest

final class MealServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMealSearchByFirstLetter() throws {
        let expectation = expectation(description: "MEAL_SEARCH_BY_FIRST_LETTER")
        
        var meals: [Meal] = []
        
        MealService.fetchMeals(startingWith: "a") { result in
            switch result {
            case .success(let responseMeals): meals = responseMeals
            case .failure(let error): debugPrint(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
        XCTAssertNotNil(meals)
    }
    
    func testMealSearchByWrongFirstLetter() throws {
        let expectation = expectation(description: "MEAL_SEARCH_BY_WRONG_FIRST_LETTER")
        
        var meals: [Meal] = []
        
        MealService.fetchMeals(startingWith: "1") { result in
            switch result {
            case .success(let responseMeals): meals = responseMeals
            case .failure(let error): debugPrint(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
        XCTAssertNotNil(meals)
    }
    
    func testMealSearchByID() throws {
        let expectation = expectation(description: "MEAL_SEARCH_BY_ID")
        
        var meal: Meal? = nil
        
        MealService.fetchMealDetails(with: "52772") { result in
            switch result {
            case .success(let responseMeal): meal = responseMeal
            case .failure(let error): debugPrint(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
        XCTAssertNotNil(meal)
    }
    
    func testMealSearchByWrongID() throws {
        let expectation = expectation(description: "MEAL_SEARCH_BY_WRONG_ID")
        
        var meal: Meal? = nil
        
        MealService.fetchMealDetails(with: "1") { result in
            switch result {
            case .success(let responseMeal): meal = responseMeal
            case .failure(let error): debugPrint(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
        XCTAssertNil(meal)
    }

}
