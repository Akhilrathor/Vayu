//
//  InterviewPrepUITests.swift
//  InterviewPrepUITests
//
//  Created by Akhilesh Rathor on 27/07/25.
//
/*
 44) explain Ui test cases?
 Ans.
 
 UI test cases are automated tests that simulate user interactions with your app’s user interface. Their purpose is to verify that the app responds correctly to user actions—like tapping buttons, entering text, or navigating screens—ensuring the whole app workflow works as intended.
 
 
 */

import XCTest

final class InterviewPrepUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let userNameField = app/*@START_MENU_TOKEN@*/.textFields["Username"]/*[[".otherElements.textFields[\"Username\"]",".textFields.firstMatch",".textFields[\"Username\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(userNameField.exists)
        
        userNameField.tap()
        userNameField.typeText("Akhilesh")
        
        let passwordSecureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["Password"]/*[[".otherElements.secureTextFields[\"Password\"]",".secureTextFields.firstMatch",".secureTextFields[\"Password\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(passwordSecureTextField.exists)
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("password")
        
        let button = app/*@START_MENU_TOKEN@*/.buttons["Continue"]/*[[".otherElements.buttons[\"Continue\"]",".buttons[\"Continue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(button.exists)
        button.tap()
        
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
