//
//  DetailViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 20.08.2023.
//

import SwiftUI

final class DetailViewModel: DetailViewModelProtocol, ObservableObject {
	@Published private(set) var episodes: [EpisodeModel] = []
	@Published private(set) var character: CharacterDetailModel?
	@Published private(set) var image: UIImage?
	@Published var isLoading = true
	@Published var showError = false
	@Published var error: String?

	private var loadTask: Task<Void, Never>?

	private let router: RouterProtocol?
	private let networkService: NetworkServiceProtocol
	private let imageLoader: ImageLoaderService
	private let urlCharacter: URL

	init(
		router: RouterProtocol,
		networkService: NetworkServiceProtocol,
		imageLoader: ImageLoaderService,
		urlCharacter: URL
	) {
		self.router = router
		self.networkService = networkService
		self.imageLoader = imageLoader
		self.urlCharacter = urlCharacter
	}

	func task() {
		loadTask?.cancel()
		loadTask = Task {
			await fetchCharacterDetail()
		}
	}

	// MARK: - Private
   
    @MainActor
	private func fetchCharacterDetail() async {
		do {
			let fetchCharacter = try await networkService.fetchRequest(
				modelType: CharacterDetailModel.self,
				with: urlCharacter
			)

			self.character = fetchCharacter

			async let episodesTask = fetchEpisodes(for: character?.episode ?? [])
			async let imageTask = loadImage(for: character?.image)
			
			do {
				self.episodes = try await episodesTask
				self.image = try await imageTask
			} catch {
				self.error = error.localizedDescription
				self.showError = true
			}
			isLoading = false
            
		} catch let networkError as NetworkError {
			isLoading = false
			switch networkError {
			case .badRequest:
				error = Constants.badRequest
			case .badResponse:
                error = Constants.badResponse
			case .localized(description: let description):
				error = description
			}
			showError = true
		} catch {
            isLoading = false
            showError = true
            self.error = Constants.unexpectedError
		}
	}

	private func fetchEpisodes(for urls: [URL?]) async throws -> [EpisodeModel] {
		try await withThrowingTaskGroup(of: EpisodeModel?.self) { group in
			for url in urls {
				if let url = url {
					group.addTask {
						try await self.networkService.fetchRequest(
							modelType: EpisodeModel.self,
							with: url
						)
					}
				}
			}

			var results: [EpisodeModel] = []
			for try await episode in group {
				if let episode = episode {
					results.append(episode)
				}
			}
			return results.sorted { $0.id < $1.id }
		}
	}

	private func loadImage(for url: URL?) async throws -> UIImage? {
		guard let url else { return nil }
		return try await imageLoader.loadImage(for: url)
	}
}
