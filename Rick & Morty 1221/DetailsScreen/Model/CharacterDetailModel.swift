//
//  CharacterDetailModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import SwiftUI

struct CharacterDetailModel: Decodable {
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let image: URL
    let episode: [URL]

	func statusColor() -> Color {
		switch status {
		case Constants.alive:
			return Color(hex: Colors.green)
		case Constants.dead:
			return .red
		case Constants.unknown:
			return .orange
		default:
			return .gray
		}
	}
}

struct Location: Decodable {
    let name: String
}
