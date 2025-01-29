//
//  DetailInfoView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 22.08.2023.
//

import SwiftUI

struct HeaderView: View {
    let model: CharacterDetailModel
    @StateObject var viewModel: DetailViewModel

    var body: some View {
		VStack(spacing: .zero) {			
			if let image = viewModel.image {
				Image(uiImage: image)
					.resizable()
					.frame(width: 148, height: 148)
					.cornerRadius(16)
					.padding(.vertical, 24)
			}
			
			Text(model.name)
				.foregroundColor(.white)
				.font(.system(size: 22))
				.fontWeight(.bold)
				.padding(.bottom, 8)
			
			Text(model.status)
				.foregroundColor(viewModel.statusColor(for: model.status))
				.font(.system(size: 16))
				.fontWeight(.medium)
				.padding(.bottom, 8)
		}
		.task {
			viewModel.loadImage(for: model.image)
		}
    }
}
