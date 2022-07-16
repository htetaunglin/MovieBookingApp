//
//  MovieBookingAppUITests.swift
//  MovieBookingAppUITests
//
//  Created by Htet Aung Lin on 14/07/2022.
//

import XCTest

class MovieBookingAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_login_success() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        app.buttons["Get Started"].tap()
        let emailField = app.textFields["Enter email address"]
        emailField.tap()
        emailField.typeText("testhal2@gmail.com")
        
        let passwordField = app.secureTextFields["Enter your password"]
        passwordField.tap()
        passwordField.typeText("123456")
        passwordField.typeText("\n")
        
        let confirmBtn = app.buttons["Confirm"]
        confirmBtn.tap()
        let userName = app.staticTexts["Hi Test HAL 2!"]
        XCTAssert(userName.waitForExistence(timeout: 5))
        sleep(5)
    }
    
    func test_login_with_password_wrong() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        app.buttons["Get Started"].tap()
        let emailField = app.textFields["Enter email address"]
        emailField.tap()
        emailField.typeText("testhal2@gmail.com")
        
        let passwordField = app.secureTextFields["Enter your password"]
        passwordField.tap()
        passwordField.typeText("1234562")
        passwordField.typeText("\n")
        
        let confirmBtn = app.buttons["Confirm"]
        confirmBtn.tap()

        let alert = app.alerts.element(boundBy: 0)
        let emailWarning = alert.staticTexts["Wrong password!"]
        XCTAssert(emailWarning.waitForExistence(timeout: 2))
        XCTAssertTrue(emailWarning.exists)
        
        alert.buttons["OK"].tap()
        
        sleep(5)
    }
    
    func test_login_no_user_exist() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        app.buttons["Get Started"].tap()
        let emailField = app.textFields["Enter email address"]
        emailField.tap()
        emailField.typeText("testhal4232@gmail.com")
        
        let passwordField = app.secureTextFields["Enter your password"]
        passwordField.tap()
        passwordField.typeText("123456")
        passwordField.typeText("\n")
        
        let confirmBtn = app.buttons["Confirm"]
        confirmBtn.tap()

        let alert = app.alerts.element(boundBy: 0)
        let emailWarning = alert.staticTexts["There's is no registered account with this email."]
        XCTAssert(emailWarning.waitForExistence(timeout: 2))
        XCTAssertTrue(emailWarning.exists)
        
        alert.buttons["OK"].tap()
        
        sleep(5)
    }
    
    func test_login_form_email_empty_test() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["Get Started"].tap()
        
        let passwordField = app.secureTextFields["Enter your password"]
        passwordField.tap()
        passwordField.typeText("123456")
        passwordField.typeText("\n")
        
        let confirmBtn = app.buttons["Confirm"]
        confirmBtn.tap()
        
        let alert = app.alerts.element(boundBy: 0)
        let emailWarning = alert.staticTexts["Please input email"]
        XCTAssert(emailWarning.waitForExistence(timeout: 2))
        XCTAssertTrue(emailWarning.exists)
        
        alert.buttons["OK"].tap()
        sleep(5)
    }

    
    func test_login_form_password_empty_test() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["Get Started"].tap()
        
        let emailField = app.textFields["Enter email address"]
        emailField.tap()
        emailField.typeText("testhal@gmail.com")
        
        let passwordField = app.secureTextFields["Enter your password"]
        passwordField.tap()
        passwordField.typeText("\n")
        
        let confirmBtn = app.buttons["Confirm"]
        confirmBtn.tap()
        
        let alert = app.alerts.element(boundBy: 0)
        let emailWarning = alert.staticTexts["Please input password"]
        XCTAssert(emailWarning.waitForExistence(timeout: 2))
        XCTAssertTrue(emailWarning.exists)
        
        alert.buttons["OK"].tap()
        sleep(5)
    }
    
    func test_login_with_google() throws{
        let app = XCUIApplication()
        app.launch()

        app.buttons["Get Started"].tap()
        
        let googleBtn = app.staticTexts["Sign in with google"]
        XCTAssertTrue(googleBtn.exists)
        googleBtn.tap()
        
//        let continueBtn = app.alerts["“MovieBookingApp” Wants to Use “google.com” to Sign In"].buttons["Continue"]
        let continueBtn = app.alerts.element(boundBy: 0).buttons["Continue"]
        
        XCTAssert(continueBtn.waitForExistence(timeout: 2))
        continueBtn.tap()
        
//        let alert = app.alerts.element
//        XCTAssert(alert.waitForExistence(timeout: 2))
//        let alert = app.descendants(matching: .alert)
//        let continueBtn = app.staticTexts["Continue"]
//        XCTAssert(continueBtn.waitForExistence(timeout: 10))
//        let continueBtn = alert.staticTexts["Continue"]
//        XCTAssert(continueBtn.waitForExistence(timeout: 2))
//        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: continueBtn, handler: nil)
//        XCTAssert(continueBtn.waitForExistence(timeout: 2))
//        XCTAssertTrue(continueBtn.isHittable)
//        continueBtn.tap()
//        let hallabel = app.staticTexts["Htet Aung Lin"]
//        XCTAssert(hallabel.waitForExistence(timeout: 5))
        
        sleep(5)
        
    }
    
    func testAutoRecord() throws {
        
//        let app = app2
//        app.buttons["Get Started"].tap()
//        app.scrollViews.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 5).children(matching: .other).element(boundBy: 1).tap()
//        app.alerts["“MovieBookingApp” Wants to Use “google.com” to Sign In"].scrollViews.otherElements.buttons["Continue"].tap()
//
//        let app2 = app
//        app2/*@START_MENU_TOKEN@*/.webViews.webViews.webViews.buttons["ရှေ့ဆက်ရန်"]/*[[".otherElements[\"BrowserView?WebViewProcessID=42773\"].webViews.webViews.webViews",".otherElements[\"လက်မှတ်ထိုးဝင်ပါ - Google Accounts\"].buttons[\"ရှေ့ဆက်ရန်\"]",".buttons[\"ရှေ့ဆက်ရန်\"]",".webViews.webViews.webViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
//        app2/*@START_MENU_TOKEN@*/.webViews.webViews.webViews.staticTexts["စကားဝှက်ကို ပြရန်"]/*[[".otherElements[\"BrowserView?WebViewProcessID=42773\"].webViews.webViews.webViews",".otherElements[\"လက်မှတ်ထိုးဝင်ပါ - Google Accounts\"].staticTexts[\"စကားဝှက်ကို ပြရန်\"]",".staticTexts[\"စကားဝှက်ကို ပြရန်\"]",".webViews.webViews.webViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
//        app2/*@START_MENU_TOKEN@*/.webViews.webViews.webViews.textFields["သင့်စကားဝှက် ထည့်ပါ"]/*[[".otherElements[\"BrowserView?WebViewProcessID=42773\"].webViews.webViews.webViews",".otherElements[\"လက်မှတ်ထိုးဝင်ပါ - Google Accounts\"].textFields[\"သင့်စကားဝှက် ထည့်ပါ\"]",".textFields[\"သင့်စကားဝှက် ထည့်ပါ\"]",".webViews.webViews.webViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Get Started"].tap()
        
        let googleBtn = app.staticTexts["Sign in with google"]
        XCTAssertTrue(googleBtn.exists)
        googleBtn.tap()
        
        let button = app.alerts["“MovieBookingApp” Wants to Use “google.com” to Sign In"].scrollViews.otherElements.buttons["Continue"]
        XCTAssert(button.waitForExistence(timeout: 2))
        app/*@START_MENU_TOKEN@*/.webViews.webViews.webViews.staticTexts["Htet Aung Lin"]/*[[".otherElements[\"BrowserView?WebViewProcessID=42797\"].webViews.webViews.webViews",".otherElements[\"လက်မှတ်ထိုးဝင်ပါ - Google Accounts\"]",".links[\"Htet Aung Lin htetaunglin.study@gmail.com\"]",".links[\"Htet Aung Lin\"].staticTexts[\"Htet Aung Lin\"]",".staticTexts[\"Htet Aung Lin\"]",".webViews.webViews.webViews"],[[[-1,5,1],[-1,0,1]],[[-1,4],[-1,3],[-1,2,3],[-1,1,2]],[[-1,4],[-1,3],[-1,2,3]],[[-1,4],[-1,3]]],[0,0]]@END_MENU_TOKEN@*/.tap()
    
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

extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }
}
