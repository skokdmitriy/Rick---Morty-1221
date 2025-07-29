//
//  DetailViewModelProtocol.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.02.2025.
//

import UIKit

protocol DetailViewModelProtocol: AnyObject {
    var episodes: [EpisodeModel] { get }
    var character: CharacterDetailModel? { get }
    var isLoading: Bool { get set }
    var image: UIImage? { get }

    init(
        router: RouterProtocol,
        networkService: NetworkServiceProtocol,
        imageLoader: ImageLoaderService,
        urlCharacter: URL
    )

    func task()
}
