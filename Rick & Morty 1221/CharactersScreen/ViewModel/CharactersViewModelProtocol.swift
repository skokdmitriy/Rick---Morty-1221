//
//  CharactersViewModelProtocol.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 21.12.2024.
//

import Foundation

protocol CharacterViewModelProtocol: AnyObject {
	var characters: [CharacterModel]? { get set }
	var isLoading: Bool { get set }
	init (
		view: CharactersViewProtocol,
		networkService: NetworkServiceProtocol,
		router: RouterProtocol
	)
	func fetchInitialCharacters () async
	func fetchNextCharacters() async
	func tapOnTheCharacter(indexPath: IndexPath)
}
