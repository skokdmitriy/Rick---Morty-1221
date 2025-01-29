//
//  DetailInfoView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import SwiftUI

struct HeaderView: View {
	let model: CharacterDetailModel

	var body: some View {
		VStack(spacing: 24) {
			AsyncImage(url: model.image) { image in
				image.resizable()
			} placeholder: {
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: Color(hex: Colors.green)))
			}
			.frame(width: 148, height: 148)
			.cornerRadius(16)

			VStack(spacing: 8) {
				Text(model.name)
					.foregroundColor(.white)
					.font(.system(size: 22))
					.fontWeight(.bold)

				Text(model.status)
					.foregroundColor(model.statusColor())
					.font(.system(size: 16))
					.fontWeight(.medium)
			}
		}
	}
}
