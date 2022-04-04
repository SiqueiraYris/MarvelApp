protocol CharacterDetailViewModelProtocol {
    var loading: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }

    func getName() -> String
    func getDescription() -> String?
    func getThumbnail() -> String
    func isDescriptionHidden() -> Bool
    func getComics() -> [ComicModel]
    func validatePagination(at row: Int)
    func fetchComics()
}

final class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    private let service: CharacterDetailServiceProtocol
    private let coordinator: CharacterDetailCoordinatorProtocol
    private let character: CharacterModel
    private var comics: [ComicModel] = []
    private var currentOffset = 0
    private var currentItem = 1
    private var totalComics = 0
    private let limit = 10
    let loading: Dynamic<Bool> = Dynamic(false)
    let error: Dynamic<String?> = Dynamic(nil)

    init(service: CharacterDetailServiceProtocol,
         coordinator: CharacterDetailCoordinatorProtocol,
         character: CharacterModel) {
        self.service = service
        self.coordinator = coordinator
        self.character = character
    }

    func getName() -> String {
        character.name
    }

    func getDescription() -> String? {
        character.description
    }

    func getThumbnail() -> String {
        character.thumbnail
    }

    func isDescriptionHidden() -> Bool {
        character.description.isEmpty
    }

    func getComics() -> [ComicModel] {
        comics
    }

    func validatePagination(at row: Int) {
        if row == (comics.count - 1) && comics.count < totalComics {
            fetchComics()
        }
    }

    func fetchComics() {
        let route = CharacterDetailServiceRoute.prepare(parameters: CharacterDetailParameters(limit: limit, offset: currentOffset))
        loading.value = true

        service.request(route) { [weak self] response in
            switch response {
            case .success(let result):
                self?.comics.append(contentsOf: CharacterDetailMapper.map(from: result))
                self?.totalComics = result.data.total
                self?.loading.value = false

            case .failure(let error):
                self?.loading.value = false
                self?.error.value = error.message
            }
        }

        currentOffset+=10
    }
}
