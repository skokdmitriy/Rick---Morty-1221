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
                .font(.title5)
            
            HStack {
                Text(model.episode)
                    .foregroundColor(Color(hex: Colors.green))
                    .font(.bodySmall)
                
                Spacer()
                
                Text(model.airDate)
                    .foregroundColor(.gray)
                    .font(.bodyExtraSmall)
            }
        }
        .padding()
        .background(Color(hex: Colors.backgroundCell))
        .cornerRadius(16)
    }
}
