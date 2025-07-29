//
//  Weight+Extension.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 04.02.2025.
//

import SwiftUI
import UIKit

// MARK: - With weight

extension UIFont {
    func withWeight(_ name: String) -> UIFont {
        guard let font = UIFont(name: name, size: pointSize) else {
            return self
        }
        return font
    }
}

// MARK: - Weight

extension Font.Weight {
    var uiWeight: UIFont.Weight? {
        switch self {
        case .bold: return .bold
        case .semibold: return .semibold
        case .medium: return .medium
        default: return .bold
        }
    }
}

extension UIFont.Weight {
    var gilroy: String {
        switch self {
        case .black: return "Gilroy-Black"
        case .bold: return "Gilroy-Bold" // 700
        //case .extraBold: return "Gilroy-ExtraBold"
        case .heavy: return "Gilroy-Heavy"
        case .light: return "Gilroy-Light"
        case .medium: return "Gilroy-Medium" // 500
        case .regular: return "Gilroy-Regular"
        //case .semiBold: return "Gilroy-SemiBold"  // 600
        case .thin: return "Gilroy-Thin"
        case .ultraLight: return "Gilroy-UltraLight"
        default: return "Gilroy-Regular"
        }
    }
}
