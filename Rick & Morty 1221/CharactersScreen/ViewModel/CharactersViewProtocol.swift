//
//  CharactersViewProtocol.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 21.12.2024.
//

import Foundation

protocol CharactersViewProtocol: AnyObject {
	func didLoadNewCharacters(indexPaths: [IndexPath])
	func failure(error: NetworkError)
}
