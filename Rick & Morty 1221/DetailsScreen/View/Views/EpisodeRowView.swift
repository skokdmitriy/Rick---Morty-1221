//
//  EpisodeRowView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.09.2023.
//

import SwiftUI

struct EpisodeRowView: View {
	let model: EpisodeModel

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text(model.name)
				.foregroundColor(.white)
				.font(.system(size: 17))
				.fontWeight(.semibold)

			HStack {
				Text(model.episode)
					.foregroundColor(Color(hex: Colors.green))
					.font(.system(size: 13))
					.fontWeight(.medium)

				Spacer()

				Text(model.airDate)
					.foregroundColor(.gray)
					.font(.system(size: 12))
					.fontWeight(.medium)
			}
		}
		.padding()
		.background(Color(hex: Colors.backgroundCell))
		.cornerRadius(16)
	}
}
