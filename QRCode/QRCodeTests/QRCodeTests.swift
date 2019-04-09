//
//  QRCodeTests.swift
//  QRCodeTests
//
//  Created by Diep Nguyen on 4/4/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import XCTest
@testable import QRCode

class QRCodeTests: XCTestCase {
    
    let viewModel = LoginViewModel()
    
    override func setUp() {
        viewModel.passwordViewModel.data.value = "aAsasasasasa1"
        viewModel.emailViewModel.data.value = "diepnn@gmail.com"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testValidatePassword() {
//        XCTAssert(viewModel.validateCredentials())
    }
    
    func testValidateEmail() {
//        XCTAssert(viewModel.validateCredentials(), "invalid email")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
