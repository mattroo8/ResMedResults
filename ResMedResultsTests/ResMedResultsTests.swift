//
//  ResMedResultsTests.swift
//  ResMedResultsTests
//
//  Created by matt rooney on 27/02/2022.
//

import XCTest
@testable import ResMedResults

class ResMedResultsTests: XCTestCase {

    func testParsingResults() throws {
        
        let exp = expectation(description: "Loading Results")
        var resultResponse: SportsResultsResponse? = nil
        
        let resultsService = ResultsService(MockHTTPClient())
        resultsService.getResults(completion: { result in
            switch result {
            case .success(let resultValue):
                resultResponse = resultValue
                exp.fulfill()
            case .failure(_):
                fatalError()
            }
        })
        waitForExpectations(timeout: 3)
        XCTAssertEqual(resultResponse!.f1Results.count, 3)
        XCTAssertEqual(resultResponse!.nbaResults.count, 5)
        XCTAssertEqual(resultResponse!.f1Results.count, 3)
    }
    
    func testListingResults() throws {
        
        let exp = expectation(description: "Loading Results")
        var resultsList: [SportResult]? = nil

        let resultsService = ResultsService(MockHTTPClient())
        resultsService.getResults(completion: { result in
            switch result {
            case .success(let resultValue):
                resultsList = resultValue.listResults()
                exp.fulfill()
            case .failure(_):
                fatalError()
            }
        })
        waitForExpectations(timeout: 3)
        XCTAssertEqual(resultsList!.count, 11)
    }
    
    func testResultsTitle() throws {
        
        let exp = expectation(description: "Loading Results")
        var resultsList: [SportResult]? = nil
        
        let resultsService = ResultsService(MockHTTPClient())
        resultsService.getResults(completion: { result in
            switch result {
            case .success(let resultValue):
                resultsList = resultValue.listResults()
                exp.fulfill()
            case .failure(_):
                fatalError()
            }
        })
        waitForExpectations(timeout: 3)
        XCTAssertEqual(resultsList!.first!.titleText(), "Roland Garros: Rafael Nadal wins against Schwartzman in 3 sets")

    }

}
