import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(sentry_swiftTests.allTests),
    ]
}
#endif
