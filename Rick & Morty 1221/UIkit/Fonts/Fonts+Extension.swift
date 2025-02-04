//
//  Fonts+Extension.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 04.02.2025.
//

import SwiftUI
import UIKit

extension Font {
	static var title2: Font {
		FontsImp().title2
	}

	static var title3: Font {
		FontsImp().title3
	}
	
	static var title5: Font {
		FontsImp().title5
	}

	static var body: Font {
		FontsImp().body
	}

	static var bodySmall: Font {
		FontsImp().bodySmall
	}

	static var bodyExtraSmall: Font {
		FontsImp().bodyExtraSmall
	}
}

extension UIFont {
//	static func custom(name: String, size: CGFloat) -> UIFont {
//		guard let font = UIFont(name: name, size: size) else {
//			return .systemFont(ofSize: size)
//		}
//		return font
//	}
//
//	static var title5: UIFont {
//		return custom(name: "Inter-Medium", size: 17)
//	}


	static var title5: UIFont {
		let fontsImp = FontsImp()
		return fontsImp.title5.uiFont ?? .systemFont(ofSize: 100)
	}

}
