//
//  NyTimesMostPopularArticlesUITests.swift
//  NyTimesMostPopularArticlesUITests
//
//  Created by Syed Faraz Haider Zaidi on 13/08/2023.
//

import XCTest

final class NyTimesMostPopularArticlesUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
                    
                                                                                        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}