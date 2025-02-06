//
//  NavigationControllerAppearance+Extension.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 17.08.2023.
//

import UIKit

extension UINavigationController {
    func setupNavigationController() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor(hex: Colors.background)

		let titleFont = UIFont.title5
		let largeTitleFont = UIFont.title2

        navigationBarAppearance.titleTextAttributes = [
			.foregroundColor: UIColor.white,
			.font: titleFont
		]

        navigationBarAppearance.largeTitleTextAttributes = [
			.foregroundColor: UIColor.white,
			.font: largeTitleFont,
			NSAttributedString.Key.baselineOffset: 31
		]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
	}
}
