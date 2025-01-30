//
//  DetailViewModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 20.08.2023.
//

import SwiftUI

protocol DetailViewModelProtocol: AnyObject {
	init (networkManager: NetworkServiceProtocol, router: RouterProtocol, urlCharacter: URL)
	var episodes: [EpisodeModel] { get set }
	var character: CharacterDetailModel? { get set }
	var isLoading: Bool { get set }
	var image: UIImage? { get set }
    func fetchCharacterDetail() async
}

final class DetailViewModel: /*DetailViewModelProtocol,*/ ObservableObject {
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

	func fetchCharacterDetail() async {
			do {
				character = try await networkService.fetchRequest(
					modelType: CharacterDetailModel.self,
					with: urlCharacter
				)
				await fetchEpisodes()
				isLoading = false
			} catch {
				print("error fetch character")
			}
	}

	private func fetchEpisodes() async {
		guard let episodes = character?.episode else { return }

		await withTaskGroup(of: EpisodeModel?.self) { group in
			for url in episodes {
				group.addTask {
					do {
						return try await self.networkService.fetchRequest(
							modelType: EpisodeModel.self,
							with: url
						)
					} catch {
						print("Error fetching episode: \(error)")
						return nil
					}
				}
			}

			for await episode in group.compactMap({ $0 }) {
					self.episodes.append(episode)

			}
		}
	}

	func loadImage(for url: URL) {
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
