//
//  DetailInfoView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import SwiftUI

struct HeaderView: View {
	let model: CharacterDetailModel
	var image: UIImage

	var body: some View {
		VStack(spacing: 24) {
			Image(uiImage: image)
				.resizable()
				.frame(width: 148, height: 148)
				.cornerRadius(16)

			VStack(spacing: 8) {
				Text(model.name)
					.foregroundColor(.white)
					.font(.title3)

				Text(model.status)
					.foregroundColor(model.statusColor())
					.font(.body)
			}
		}
		.padding(.top, 16)
	}
}
