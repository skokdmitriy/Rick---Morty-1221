//
//  CharacterViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 19.08.2023.
//

import Foundation

// MARK: - CharacterViewModel

final class CharacterViewModel: CharacterViewModelProtocol {
	weak var view: CharactersViewProtocol?
	let networkService: NetworkServiceProtocol
	var router: RouterProtocol?
	var characters: [CharacterModel]?
	var isLoading: Bool = false
	var nextPage: URL?

	required init (
		view: CharactersViewProtocol,
		networkService: NetworkServiceProtocol,
		router: RouterProtocol
	) {
		self.view = view
		self.networkService = networkService
		self.router = router
	}

	// MARK: - Public Methods

	func fetchInitialCharacters() async {
		await fetchCharacters(from: Constants.characterApi)
	}

	func fetchNextCharacters() async {
		await fetchCharacters(from: nextPage)
	}

	func tapOnTheCharacter(indexPath: IndexPath) {
		guard let character = characters?[indexPath.item] else {
			return
		}
		router?.showDetail(urlCharacter: character.url)
	}

	// MARK: - Private

	@MainActor
	private func fetchCharacters(from url: URL?) async {
		guard let url, !isLoading else { return }
		isLoading = true

		do {
			let characterResponse: Characters = try await networkService.fetchRequest(
				modelType: Characters.self,
				with: url
			)
			let indexPath = createIndexPaths(for: characterResponse.results)
			updateCharacters(with: characterResponse.results)
			self.nextPage = characterResponse.info.next
			self.view?.didLoadNewCharacters(indexPaths: indexPath)
		} catch let networkError as NetworkError {
			self.view?.failure(error: networkError)
		} catch {
			self.view?.failure(error: .localized(description: "Неожидання ошибка"))
		}

		isLoading = false
	}

	private func createIndexPaths(for newCharacters: [CharacterModel]) -> [IndexPath] {
		let startIndex = characters?.count ?? 0
		let endIndex = startIndex + newCharacters.count
		return (startIndex..<endIndex).map { IndexPath(item: $0, section: 0) }
	}

	private func updateCharacters(with newCharacters: [CharacterModel]) {
		if characters == nil {
			characters = newCharacters
		} else {
			characters?.append(contentsOf: newCharacters)
		}
	}
}
