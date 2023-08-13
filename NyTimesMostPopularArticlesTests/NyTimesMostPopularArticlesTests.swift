//
//  NyTimesMostPopularArticlesTests.swift
//  NyTimesMostPopularArticlesTests
//
//  Created by Syed Faraz Haider Zaidi on 13/08/2023.
//

import XCTest
@testable import NyTimesMostPopularArticles

final class NyTimesMostPopularArticlesTests: XCTestCase {

    func testFetchData_WithInternetAvailable_ShouldFetchData() {
           // Create a mock networking class
           let networking = Networking()
           let viewModel = ArticleViewModel(networking: networking)
           
           // Set up the expectation
           let expectation = XCTestExpectation(description: "Data fetched successfully")
           
           // Call the fetchData method
           viewModel.fetchData()
           
           // Fulfill the expectation after a delay to simulate network request completion
           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               // Assert that articles are not nil
               XCTAssertNotNil(viewModel.articles)
               
               // Fulfill the expectation
               expectation.fulfill()
           }
           
           // Wait for the expectation to be fulfilled
           wait(for: [expectation], timeout: 2.0)
       }

}
