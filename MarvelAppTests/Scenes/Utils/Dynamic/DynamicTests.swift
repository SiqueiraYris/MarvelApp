import XCTest
@testable import MarvelApp

final class DynamicTests: XCTestCase {
    func test_init_itShouldInitsValueCorrectly() {
        let dynamic = Dynamic(false)

        XCTAssertFalse(dynamic.value)
    }

    func test_value_itShouldSetValueCorrectly() {
        let dynamic = Dynamic(false)

        dynamic.value = true

        XCTAssertTrue(dynamic.value)
    }

    func test_bind_itShouldBindsValueCorrectly() {
        let receivedValue: Dynamic<Bool?> = Dynamic(nil)
        let dynamic = Dynamic(false)

        dynamic.bind { value in
            receivedValue.value = value
        }
        dynamic.value = true

        XCTAssertEqual(dynamic.value, receivedValue.value)
    }
}
