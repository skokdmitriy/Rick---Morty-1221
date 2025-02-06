//
//  DetailViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 20.08.2023.
//

import SwiftUI

@MainActor
final class DetailViewModel: DetailViewModelProtocol, ObservableObject {
	@Published var episodes: [EpisodeModel] = []
	@Published var character: CharacterDetailModel?
	@Published var isLoading = true
	@Published var image: UIImage?

	private var loadTask: Task<Void, Never>?
	private let imageLoader = ImageLoaderService()

	private let router: RouterProtocol?
	private let networkService: NetworkServiceProtocol
	private let urlCharacter: URL

	required init(networkManager: NetworkServiceProtocol, router: RouterProtocol, urlCharacter: URL) {
		self.networkService = networkManager
		self.urlCharacter = urlCharacter
		self.router = router
	}

	func task() async {
		await fetchCharacterDetail()
		loadImage()
	}

	// MARK: - Private

	private func fetchCharacterDetail() async {

		do {
			character = try await networkService.fetchRequest(
				modelType: CharacterDetailModel.self,
				with: urlCharacter
			)
			await fetchEpisodes()
			isLoading = false
		} catch {
			print("Failed to fetch character: \(error)")
		}
	}

	private func fetchEpisodes() async {
		guard let urls = character?.episode else { return }

		do {
			self.episodes = try await withThrowingTaskGroup(of: EpisodeModel?.self) { group in
				for url in urls {
					group.addTask {
						try await self.networkService.fetchRequest(
							modelType: EpisodeModel.self,
							with: url
						)
					}
				}
				var episodes: [EpisodeModel] = []
				for try await episode in group {
					if let episode = episode {
						episodes.append(episode)
					}
				}
				return episodes.sorted { $0.id < $1.id }
			}
			
		} catch {
			print("Failed to fetch episodes: \(error)")
		}
	}

	private func loadImage() {
		guard let url = character?.image else { return }
		loadTask?.cancel()

		loadTask = Task { [weak self] in
			guard let self else { return }

			do {
				async let image = try await self.imageLoader.loadImage(for: url)
				self.image = try await image
			} catch {
				print("error")
			}
		}
	}
}
