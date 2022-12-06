//
//  EpisodeDetailView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import Foundation
import SwiftUI
import NukeUI

struct EpisodeDetailView: View {
    @EnvironmentObject var viewModel: EpisodeDetailViewModel

    var body: some View {
        VStack {
            if let imageUrl = viewModel.episode.image.original, let url = URL(string: imageUrl) {
                LazyImage(url: url, resizingMode: .aspectFill)
                    .frame(height: 200)
                    .cornerRadius(5)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text("S\(String(format: "%02d", viewModel.episode.season)) | E\(String(format: "%02d", viewModel.episode.number))")
                        .font(.headline)
                        .fontWeight(.heavy)

                    Text(viewModel.episode.name)
                        .lineLimit(1)
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineSpacing(4)
                }

                Spacer()

                if let rating = viewModel.episode.rating.average {
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.yellow)

                        Text("\(String(format: "%.1f", rating)) / 10")
                            .font(.system(size: 12)).bold()
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
                
            }
            .padding(.vertical)

            Text(viewModel.episode.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
                .font(.system(size: 14))
                .lineSpacing(4)
                .foregroundColor(.gray)

            HStack {
                Image(systemName: "clock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray)

                Text("Aired on " + viewModel.episode.airdate)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)
            }
            .frame(alignment: .leading)
            .padding(8)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .padding()
    }
}

struct EpisodeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailView()
    }
}
