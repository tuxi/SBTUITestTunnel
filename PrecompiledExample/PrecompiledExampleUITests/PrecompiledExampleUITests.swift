//
//  PrecompiledExampleUITests.swift
//  PrecompiledExampleUITests
//
//  Created by tomas on 18/09/2019.
//  Copyright © 2019 Subito.it. All rights reserved.
//

import XCTest
import SBTUITestTunnel

class PrecompiledExampleUITests: XCTestCase {
    func testExample() {
        // UI tests must launch the application that they test.
        app.launchTunnel()
        
        app.stubRequests(matching: SBTRequestMatch(url: "http://www.google.com"), response: SBTStubResponse(response: "[]", responseTime: 0.1))

        app.buttons["Button"].tap()
    }
}
