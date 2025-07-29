//
//  UIFont+Extension.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 06.02.2025.
//

import UIKit

extension UIFont {
    static func custom(name: String, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: name, size: size) else {
            return .systemFont(ofSize: size)
        }
        return font
    }

    static var title5: UIFont {
        return custom(name: "Gilroy-Medium", size: 17)
    }

    static var title2: UIFont {
        return custom(name: "Gilroy-Bold", size: 28)
    }
}
