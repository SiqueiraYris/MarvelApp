import XCTest
@testable import MarvelApp

final class DynamicObserverTests: XCTestCase {
    func test_addValue_itShouldSetsValuesCorrectly() {
        let dynamicObserver = DynamicObserver<Bool>()

        dynamicObserver.addValue(false)
        dynamicObserver.addValue(true)

        XCTAssertEqual(dynamicObserver.values, [false, true])
    }
}
