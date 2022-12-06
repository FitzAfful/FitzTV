//
//  FavoriteButton.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import Foundation
import SwiftUI

struct FavoriteButton: View {
    var isFavorited: Bool
    var onFavoriteChange: (Bool) -> Void = { _ in }

    var body: some View {
        Button {
            onFavoriteChange(isFavorited)
        } label: {
            HStack {
                Image(systemName: isFavorited ? "heart" : "heart.fill")
                    .frame(width: 12, height: 12)
                    .padding(.leading, 8)
                    .foregroundColor(.white)

                Text(isFavorited ? "Remove from favorites" : "Add to favorites")
                    .font(.system(size: 12))
                    .foregroundColor(.white)
                    .padding(.trailing, 4)
            }
        }
        .padding(8)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
