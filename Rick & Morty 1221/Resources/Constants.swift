//
//  Constants.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 20.09.2023.
//

import Foundation

public enum Constants {
	static let characterApi = URL(string: "https://rickandmortyapi.com/api/character")
    static let badData = "Ваши данные - плохие..."
    static let badRequest = "С запросом точно все ок?"
	static let badDecode = "Не удалось декодировать"
    static let cellIdentifier = "cellIdentifier"
    static let title = "Characters"
    static let alertTitle = "Произошла ошибка"
    static let textEpisodes = "Episodes"
    static let titleInfo = "Info"
    static let textSpecies = "Species:"
    static let textType = "Type:"
    static let textNone = "None"
    static let textGender = "Gender:"
    static let textOrigin = "Origin"
    static let textPlanet = "Planet"
    static let alive = "Alive"
    static let dead = "Dead"
    static let unknown = "Unknown"
}

public enum Icons {
	static let planetIcon = "planet.icon"
}

public enum Colors {
	static let background = "#040C1E"
	static let backgroundCell = "#262A38"
	static let dark = "#191C2A"
	static let green = "#47C60B"
}
