import Foundation

enum Strings: String {
    case characterListTitle = "CharacterListTitle"
    case thumbnailSeparator = "ThumbnailSeparator"
    case ok = "Ok"
    case errorTitle = "ErrorTitle"
    case relatedComicsTitle = "RelatedComicsTitle"

    public var text: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
