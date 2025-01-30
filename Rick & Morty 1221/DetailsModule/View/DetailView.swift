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
                        if let detailModel = viewModel.character {
							HeaderView(model: detailModel)
                            InfoSectionView(model: detailModel)
                            OriginSectionView(characterDetailModel: detailModel)
                            makeEpisodesSection()
                        }
                    }
					.padding(.horizontal, 24)
                }
            }
        }
		.task {
			await viewModel.fetchCharacterDetail()
		}
    }

    private func makeEpisodesSection() -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(Constants.textEpisodes)
                .foregroundColor(.white)
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .frame(alignment: .topLeading)
                .padding(.bottom)
                .padding(.leading, 24)

            ForEach(viewModel.episodes, id: \.self) { episodeModel in
                EpisodeView(episodeModel: episodeModel)
            }
        }
    }
}
