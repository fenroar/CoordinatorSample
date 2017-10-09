//
//  CoordinatorSampleUITests.swift
//  CoordinatorSampleUITests
//
//  Created by Peter Su on 24/09/2017.
//  Copyright © 2017 fenroar. All rights reserved.
//

import XCTest

class CoordinatorSampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testLogin() {
        
        let app = XCUIApplication()
        app.buttons["Show Login"].tap()
        
        let emailTextField = app.textFields["Email"] // email
        emailTextField.tap()
        emailTextField.typeText("sample@email.com")
        
        let passwordTextField = app.textFields["Password"] // email
        passwordTextField.tap()
        passwordTextField.typeText("password")
        
        let loginButton = app.buttons["Log in"]
        loginButton.tap()
        
        let predicate = NSPredicate(format: "exists == 1")
        let query = app.staticTexts["Main View"]
        expectation(for: predicate, evaluatedWith: query, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
    
    
    func testRegistration() {
        
        let app = XCUIApplication()
        app.buttons["Show Registration"].tap()
        
        let usernameTextField = app.textFields["Username"] // username
        usernameTextField.tap()
        usernameTextField.typeText("my_user_name")
        
        let doneButton = app.buttons["Done"]
        doneButton.tap()
        
        let emailTextField = app.textFields["Email"] // email
        emailTextField.tap()
        emailTextField.typeText("sample@email.com")
        
        let passwordTextField = app.textFields["Password"] // email
        passwordTextField.tap()
        passwordTextField.typeText("password")
        
        let nextButton = app.buttons["Next"]
        nextButton.tap()
        
        let predicate = NSPredicate(format: "exists == 1")
        let query = app.staticTexts["Main View"]
        expectation(for: predicate, evaluatedWith: query, handler: .none)
        waitForExpectations(timeout: 5, handler: .none)
    }
}
