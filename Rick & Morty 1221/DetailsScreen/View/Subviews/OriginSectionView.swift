//
//  OriginSectionView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.09.2023.
//

import SwiftUI

struct OriginSectionView: View {
    let model: CharacterDetailModel

    var body: some View {
		VStack(alignment: .leading, spacing: 16) {
            Text(Constants.textOrigin)
                .foregroundColor(.white)
				.font(.title5)

            HStack {
                ZStack {
                    Image(Icons.planetIcon)
                }
                .frame(width: 64, height: 64)
				.background(Color(hex: Colors.dark))
                .cornerRadius(10)
                .padding(.trailing, 16)

                VStack(alignment: .leading, spacing: 8) {
                    Text(model.origin.name)
                        .foregroundColor(.white)
						.font(.title5)

                    Text(Constants.textPlanet)
						.foregroundColor(Color(hex: Colors.green))
                        .font(.bodySmall)
                }

                Spacer()
            }
            .padding([.leading, .bottom, .top], 8)
            .background(Color(hex: Colors.backgroundCell))
            .cornerRadius(16)
        }
    }
}
