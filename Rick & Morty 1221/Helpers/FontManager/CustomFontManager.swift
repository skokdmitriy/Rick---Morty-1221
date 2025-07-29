//
//  CustomFontManager.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.02.2025.
//

import UIKit

class CustomFontManager {
    static func registrationCustomFounts() {
        let fountURLs = fetchFountsURLs(withExtension: "ttf", isSubdirectory: "Resources/Fonts")
    }

    private static func fetchFountsURLs(
        withExtension: String,
        isSubdirectory subdirectory: String?
    ) -> [URL] {
        return Bundle(for: self).urls(
            forResourcesWithExtension: withExtension,
            subdirectory: subdirectory
        ) ?? []
    }

    private static func registrationFont(form url: URL) -> Bool {
        return CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
}
