import XCTest
@testable import SwiftenvFlock

class SwiftenvFlockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SwiftenvFlock().text, "Hello, World!")
    }


    static var allTests : [(String, (SwiftenvFlockTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
