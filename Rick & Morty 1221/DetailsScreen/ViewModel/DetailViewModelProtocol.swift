//
//  DetailViewModelProtocol.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.02.2025.
//

import UIKit

@MainActor
protocol DetailViewModelProtocol: AnyObject {
	init (networkManager: NetworkServiceProtocol, router: RouterProtocol, urlCharacter: URL) async
	var episodes: [EpisodeModel] { get set }
	var character: CharacterDetailModel? { get set }
	var isLoading: Bool { get set }
	var image: UIImage? { get set }
}
