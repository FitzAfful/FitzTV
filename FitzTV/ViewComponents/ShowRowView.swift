//
//  ShowRowView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI
import NukeUI

struct ShowRowView: View {
    var show: Show

    var body: some View {
        HStack {

            if let imageUrl = show.image.medium, let url = URL(string: imageUrl) {
                LazyImage(url: url, resizingMode: .aspectFill)
                    .frame(width: 67.5, height: 100)
                    .cornerRadius(5)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(show.name)
                    .lineLimit(1)
                    .font(.subheadline)

                Text(show.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
                    .lineLimit(3)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)

                Text(show.genres.joined(separator: " • "))
                    .lineLimit(4)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .padding(4)
                    .background(.yellow.opacity(0.3))
                    .clipShape(Capsule())
            }
            .frame(alignment: .center)
        }
    }
}
