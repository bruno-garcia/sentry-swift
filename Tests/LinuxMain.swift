import XCTest

import SentryTests

var tests = [XCTestCaseEntry]()
tests += SentryTests.allTests()
XCTMain(tests)
