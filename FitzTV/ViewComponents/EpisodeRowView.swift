//
//  EpisodeRowView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI
import NukeUI

struct EpisodeRowView: View {
    var episode: Episode

    var body: some View {
        HStack {

            if let imageUrl = episode.image.medium, let url = URL(string: imageUrl) {
                LazyImage(url: url, resizingMode: .aspectFill)
                    .frame(width: 100, height: 67.5)
                    .cornerRadius(5)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text("S\(String(format: "%02d", episode.season)) | E\(String(format: "%02d", episode.number)): " + episode.name)
                    .lineLimit(1)
                    .font(.system(size: 12)).bold()

                Text(episode.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
                    .lineLimit(2)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            .frame(alignment: .center)

            Image(systemName: "chevron.right")
                .frame(width: 10, height: 10, alignment: .center)
                .foregroundColor(.gray)
        }
        .accentColor(.black)
    }
}
