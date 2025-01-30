//
//  EpisodeModel.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import Foundation

struct EpisodeModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
}
