//
//  AssignmentUITests.swift
//  AssignmentUITests
//
//  Created by itst on 6/1/2023.
//

import XCTest

class AssignmentUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Settings"].tap()
        
        let clickToLoginButton = app.buttons["Click to Login"]
        clickToLoginButton.tap()
        clickToLoginButton.tap()
        tabBar.buttons["New"].tap()
        
        let shopButton = tabBar.buttons["Shop"]
        shopButton.tap()
        
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        let test240Button = elementsQuery.buttons["Test2, 40$"]
        test240Button.tap()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"Test2").children(matching: .image).element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        let yyyy70Button = elementsQuery.buttons["YYYY, 70$"]
        yyyy70Button.tap()
        
        let image = scrollViewsQuery.otherElements.containing(.staticText, identifier:"YYYY").children(matching: .image).element
        let addToCartButton = elementsQuery.buttons["Add to cart"]
        addToCartButton.tap()
        scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .button).matching(identifier: "Favorite").element(boundBy: 1).tap()
        tabBar.buttons["Favorites"].tap()
        elementsQuery.buttons["Favorite"].tap()
        shopButton.tap()
        test240Button.tap()
        addToCartButton.tap()
        
        let button = app.navigationBars["Shop"].buttons["1"]
        button.tap()
        elementsQuery.images["Trash"].tap()
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Shop"].tap()
        yyyy70Button.tap()
        addToCartButton.tap()
        button.tap()
        
        let clickToCheckoutButton = elementsQuery.buttons["Click to Checkout"]
        clickToCheckoutButton.tap()
        clickToCheckoutButton.tap()
        app.alerts["Allow “Assignment” to use your location?"].scrollViews.otherElements.buttons["Allow Once"].tap()
        app.tables.cells["Auto Fill Your Location"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
