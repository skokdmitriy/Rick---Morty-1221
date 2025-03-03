//
//  DetailView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 18.08.2023.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel

    var body: some View {
        ZStack {
			Color(hex: Colors.background).ignoresSafeArea()

            if viewModel.isLoading {
                ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: Color(hex: Colors.green)))
            } else {
                ScrollView {
					VStack(spacing: 24) {
                        if let detailModel = viewModel.character,
						   let image = viewModel.image {
							HeaderView(model: detailModel, image: image)
                            InfoSectionView(model: detailModel)
                            OriginSectionView(model: detailModel)
							episodeSectionView
						}
                    }
					.padding(.horizontal, 24)
                }
            }
        }
		.task {
			viewModel.task()
		}
    }
}

// MARK: - EpisodeSectionView

private extension DetailView {
	var episodeSectionView: some View {
		LazyVStack(alignment: .leading, spacing: 16) {
			Text(Constants.textEpisodes)
				.foregroundColor(.white)
				.font(.title5)
			ForEach(viewModel.episodes) { episode in
				EpisodeRowView(model: episode)
			}
		}
	}
}
