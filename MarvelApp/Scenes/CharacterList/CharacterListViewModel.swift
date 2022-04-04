protocol CharacterListViewModelProtocol {
    var loading: Dynamic<Bool> { get }
    var error: Dynamic<String?> { get }

    func title() -> String
    func numberOfRows() -> Int
    func cellForRow(at row: Int) -> CharacterModel
    func heightForRowAt() -> Int
    func didSelectRowAt(at row: Int)
    func validatePagination(at row: Int)
    func fetchCharacters()
}

final class CharacterListViewModel: CharacterListViewModelProtocol {
    private let service: CharacterListServiceProtocol
    private let coordinator: CharacterListCoordinatorProtocol
    private var characters: [CharacterModel] = []
    private var currentOffset = 0
    private var currentItem = 1
    private var totalCharacters = 0
    private let limit = 10
    let loading: Dynamic<Bool> = Dynamic(false)
    let error: Dynamic<String?> = Dynamic(nil)

    init(service: CharacterListServiceProtocol, coordinator: CharacterListCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }

    func title() -> String {
        Strings.characterListTitle.text
    }

    func numberOfRows() -> Int {
        characters.count
    }

    func cellForRow(at row: Int) -> CharacterModel {
        currentItem+=1
        return characters[row]
    }

    func heightForRowAt() -> Int {
        160
    }

    func didSelectRowAt(at row: Int) {
        coordinator.shouldShowCharacterDetails(characters[row])
    }

    func validatePagination(at row: Int) {
        if row == (characters.count - 1) && characters.count < totalCharacters {
            fetchCharacters()
        }
    }

    func fetchCharacters() {
        let route = CharacterListServiceRoute.prepare(parameters: CharacterListParameters(limit: limit, offset: currentOffset))
        loading.value = true

        service.request(route) { [weak self] response in
            switch response {
            case .success(let result):
                self?.characters.append(contentsOf: CharacterListMapper.map(from: result))
                self?.totalCharacters = result.data.total
                self?.loading.value = false

            case .failure(let error):
                self?.loading.value = false
                self?.error.value = error.message
            }
        }

        currentOffset+=limit
    }
}
