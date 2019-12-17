//
//  UnusedStubsPeekAll.swift
//  SBTUITestTunnel_Tests
//
//  Created by DMITRY KULAKOV on 20.11.2019.
//  Copyright © 2019 Tomas Camin. All rights reserved.
//
import SBTUITestTunnelClient
import SBTUITestTunnelServer
import Foundation
import XCTest

class UnusedStubsPeekAllTests: XCTestCase {

    private let request = NetworkRequests()

    func testForOneMatchAndRemoveAfterTwoIterationsNotUsed() {
        let match = SBTRequestMatch(url: "httpbin.org")
        let removeAfterIterations: Int = 2
        app.stubRequests(matching: match,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.monitorRequests(matching: match)
        
        let unusedCount = unusedStubs(matching: match, removeAfterIterations: removeAfterIterations)
        XCTAssertEqual(unusedCount, removeAfterIterations)
    }

    func testForOneMatchAndRemoveAfterTwoIterationsUsedOnce() {
        let match = SBTRequestMatch(url: "httpbin.org")
        let removeAfterIterations: Int = 2
        app.stubRequests(matching: match,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.monitorRequests(matching: match)

        let result = request.dataTaskNetwork(urlString: "http://httpbin.org/get")
        XCTAssert(request.isStubbed(result))

        let unusedCount = unusedStubs(matching: match, removeAfterIterations: removeAfterIterations)
        XCTAssertEqual(unusedCount, removeAfterIterations - 1)
    }

    func testForOneMatchAndRemoveAfterTwoIterationsUsedTwice() {
        let match = SBTRequestMatch(url: "httpbin.org")
        let removeAfterIterations: Int = 2
        app.stubRequests(matching: match,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.monitorRequests(matching: match)

        for _ in 0...1 {
            let result = request.dataTaskNetwork(urlString: "http://httpbin.org/get")
            XCTAssert(request.isStubbed(result))
        }
        
        let unusedCount = unusedStubs(matching: match, removeAfterIterations: removeAfterIterations)
        XCTAssertEqual(unusedCount, removeAfterIterations - 2)
    }

    func testForOneMatchAndWithoutDefiningRemoveAfterTwoIterationsNotUsed() {
        let match = SBTRequestMatch(url: "httpbin.org")
        app.stubRequests(matching: match,
                         response: SBTStubResponse(response: ["stubbed": 1]))
        app.monitorRequests(matching: match)
        
        let unusedCount = unusedStubs(matching: match)
        XCTAssertEqual(unusedCount, 0)
    }

    func testForOneMatchAndWithoutDefiningRemoveAfterTwoIterationsUsedOnce() {
        let match = SBTRequestMatch(url: "httpbin.org")
        app.stubRequests(matching: match,
                         response: SBTStubResponse(response: ["stubbed": 1]))
        app.monitorRequests(matching: match)
        
        let unusedCount = unusedStubs(matching: match)
        XCTAssertEqual(unusedCount, 0)
    }

    func testForOneMatchAndWithoutDefiningZeroRemoveAfterTwoIterationsNotUsed() {
        let match = SBTRequestMatch(url: "httpbin.org")
        let removeAfterIterations: Int = 0
        app.stubRequests(matching: match,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.monitorRequests(matching: match)
        
        let unusedCount = unusedStubs(matching: match, removeAfterIterations: removeAfterIterations)
        XCTAssertEqual(unusedCount, removeAfterIterations)
    }

    func testForOneMatchAndWithoutDefiningZeroRemoveAfterTwoIterationsUsedOnce() {
        let match = SBTRequestMatch(url: "httpbin.org")
        let removeAfterIterations: Int = 0
        app.stubRequests(matching: match,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.monitorRequests(matching: match)

        let unusedCount = unusedStubs(matching: match, removeAfterIterations: removeAfterIterations)
        XCTAssertEqual(unusedCount, removeAfterIterations)
    }

    func testForTwoMatchesAndRemoveAfterTwoIterationsForOneNotUsed() {
        let firstMatch = SBTRequestMatch(url: "httpbin.org")
        let secondMatch = SBTRequestMatch(url: "go.gl")
        let removeAfterIterations: Int = 2
        app.stubRequests(matching: firstMatch,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.stubRequests(matching: secondMatch,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.monitorRequests(matching: firstMatch)
        app.monitorRequests(matching: secondMatch)
        
        let unusedCountFirstMatch = unusedStubs(matching: firstMatch, removeAfterIterations: removeAfterIterations)
        let unusedCountSecondMatch = unusedStubs(matching: secondMatch, removeAfterIterations: removeAfterIterations)
        
        XCTAssertEqual(unusedCountFirstMatch, removeAfterIterations)
        XCTAssertEqual(unusedCountSecondMatch, removeAfterIterations)
    }

    func testForTwoMatchesAndRemoveAfterTwoIterationsForOneUsedOnce() {
        let firstMatch = SBTRequestMatch(url: "httpbin.org")
        let secondMatch = SBTRequestMatch(url: "go.gl")
        let removeAfterIterations: Int = 2
        app.stubRequests(matching: firstMatch,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.stubRequests(matching: secondMatch,
                         response: SBTStubResponse(response: ["stubbed": 1]),
                         removeAfterIterations: UInt(removeAfterIterations))
        app.monitorRequests(matching: firstMatch)
        app.monitorRequests(matching: secondMatch)

        let result = request.dataTaskNetwork(urlString: "http://httpbin.org/get")
        XCTAssert(request.isStubbed(result))

        let unusedCountFirstMatch = unusedStubs(matching: firstMatch, removeAfterIterations: removeAfterIterations)
        let unusedCountSecondMatch = unusedStubs(matching: secondMatch, removeAfterIterations: removeAfterIterations)
        
        XCTAssertEqual(unusedCountFirstMatch, removeAfterIterations - 1)
        XCTAssertEqual(unusedCountSecondMatch, removeAfterIterations)
    }
    
    private func unusedStubs(matching match: SBTRequestMatch, removeAfterIterations: Int = 0) -> Int {
        let requests = app.monitoredRequestsPeekAll()
        let unusedCount = max(0, removeAfterIterations - requests.filter { $0.matches(match) && $0.isStubbed }.count)

        return unusedCount
    }
}

extension UnusedStubsPeekAllTests {
    override func setUp() {
        app.launchConnectionless { (path, params) -> String in
            return SBTUITestTunnelServer.performCommand(path, params: params)
        }
    }
}
