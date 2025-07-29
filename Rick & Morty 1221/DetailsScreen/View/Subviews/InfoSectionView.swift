//
//  InfoSectionView.swift
//  Rick & Morty 1221
//
//  Created by Дмитрий Скок on 02.09.2023.
//

import SwiftUI

struct InfoSectionView: View {
    let model: CharacterDetailModel
    private let placeholder: String = Constants.textNone

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            infoTitle

            VStack(spacing: 16) {
                infoRow(label: Constants.textSpecies, value: model.species)
                infoRow(label: Constants.textType, value: model.type)
                infoRow(label: Constants.textGender, value: model.gender)
            }
            .padding()
            .background(Color(hex: Colors.backgroundCell))
            .cornerRadius(16)
        }
    }
}

private extension InfoSectionView {

    var infoTitle: some View {
        Text(Constants.titleInfo)
            .foregroundColor(.white)
            .font(.title5)
            .frame(alignment: .topLeading)
    }

    func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundColor(Color.gray)
                .font(.body)

            Spacer()

            Text(value.isEmpty ? placeholder : value)
                .foregroundColor(Color.white)
                .font(.body)
        }
    }
}
