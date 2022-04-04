import XCTest
@testable import MarvelApp

final class StringsTests: XCTestCase {
    func test_characterListTitle_itShouldReturnsCorrectValue() {
        let text = Strings.characterListTitle.text

        XCTAssertEqual(text, "Marvel Characters")
    }

    func test_thumbnailSeparator_itShouldReturnsCorrectValue() {
        let text = Strings.thumbnailSeparator.text

        XCTAssertEqual(text, ".")
    }

    func test_ok_itShouldReturnsCorrectValue() {
        let text = Strings.ok.text

        XCTAssertEqual(text, "Ok")
    }

    func test_errorTitle_itShouldReturnsCorrectValue() {
        let text = Strings.errorTitle.text

        XCTAssertEqual(text, "An error occurred")
    }

    func test_relatedComicsTitle_itShouldReturnsCorrectValue() {
        let text = Strings.relatedComicsTitle.text

        XCTAssertEqual(text, "Comics")
    }
}
