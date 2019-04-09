//
//  ValidatePasswordTests.swift
//  QRCodeTests
//
//  Created by Diep Nguyen on 4/9/19.
//  Copyright © 2019 Diep Nguyen. All rights reserved.
//

import XCTest
@testable import QRCode

class ValidatePasswordTests: XCTestCase {

    let viewModel = PasswordViewModel()
    override func setUp() {
        // Given
        viewModel.data.value = "aA12345678"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidatePassword() {
        XCTAssert(viewModel.validateCredentials(), "Invalid password")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
