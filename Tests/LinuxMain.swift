import XCTest

import sentry_swiftTests

var tests = [XCTestCaseEntry]()
tests += sentry_swiftTests.allTests()
XCTMain(tests)
