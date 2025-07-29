//
//  CharacterDetailModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import SwiftUI

struct CharacterDetailModel: Decodable {
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let image: URL
    let episode: [URL]
}

struct Location: Decodable {
    let name: String
}

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"

    var color: Color {
        switch self {
        case .alive:
            return Color(hex: Colors.green)
        case .dead:
            return .red
        case .unknown:
            return .orange
        }
    }
}
