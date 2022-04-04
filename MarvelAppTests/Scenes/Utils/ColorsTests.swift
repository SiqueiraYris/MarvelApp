import XCTest
import UIKit
@testable import MarvelApp

final class ColorsTests: XCTestCase {
    func test_primaryMain_itShouldReturnsCorrectValue() {
        let color = Colors.primaryMain

        XCTAssertEqual(color, UIColor(red: 16/255, green: 14/255, blue: 42/255, alpha: 1))
    }

    func test_primaryLight_itShouldReturnsCorrectValue() {
        let color = Colors.primaryLight

        XCTAssertEqual(color, UIColor(red: 23/255, green: 21/255, blue: 56/255, alpha: 1))
    }

    func test_neutralLight_itShouldReturnsCorrectValue() {
        let color = Colors.neutralLight

        XCTAssertEqual(color, UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1))
    }

    func test_neutralDark_itShouldReturnsCorrectValue() {
        let color = Colors.neutralDark

        XCTAssertEqual(color, UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1))
    }
}
