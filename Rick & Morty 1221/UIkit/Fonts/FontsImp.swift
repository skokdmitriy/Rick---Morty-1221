//
//  FontsImp.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 03.02.2025.
//

import SwiftUI

struct FontsImp: Fonts {
    var title2: Font = gilroyFont(size: 28, weight: .bold)
    var title3: Font = gilroyFont(size: 22, weight: .bold)
    var title5: Font = gilroyFont(size: 17, weight: .semibold)
    var body: Font = gilroyFont(size: 16, weight: .medium)
    var bodySmall: Font = gilroyFont(size: 13, weight: .medium)
    var bodyExtraSmall: Font  = gilroyFont(size: 13, weight: .medium)

    static func gilroyFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .custom(FontsCollection(weight: weight).rawValue, size: size)
    }
}

// MARK: - FontsCollection

enum FontsCollection: String {
    case black = "Gilroy-Black"
    case bold = "Gilroy-Bold" // 700
    case extraBold = "Gilroy-ExtraBold"
    case heavy = "Gilroy-Heavy"
    case light = "Gilroy-Light"
    case medium = "Gilroy-Medium" // 500
    case regular = "Gilroy-Regular"
    case semiBold = "Gilroy-SemiBold"  // 600
    case thin = "Gilroy-Thin"
    case ultraLight = "Gilroy-UltraLight"

    init(weight: Font.Weight) {
        switch weight {
        case .black: self = .black
        case .bold: self = .bold
//      case .extraBold: self = .extraBold
        case .heavy: self = .heavy
        case .light: self = .light
        case .medium: self = .medium
        case .regular: self = .regular
        case .semibold: self = .semiBold
        case .thin: self = .thin
        case .ultraLight: self = .ultraLight
        default: self = .regular
        }
    }
}
