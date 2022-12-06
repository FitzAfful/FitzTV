//
//  ShowDetailView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI
import NukeUI

struct ShowDetailView: View {
    @EnvironmentObject var viewModel: ShowDetailViewModel
    @State private var presentEpisode = false
    let heights = stride(from: 0.6, through: 0.8, by: 0.2).map { PresentationDetent.fraction($0)}
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageUrl = viewModel.show.image?.original, let url = URL(string: imageUrl) {
                    LazyImage(url: url, resizingMode: .aspectFill)
                        .frame(height: 400)
                        .mask(LinearGradient(gradient: Gradient(stops: [
                            .init(color: .black, location: 0),
                            .init(color: .clear, location: 1),
                            .init(color: .black, location: 1),
                            .init(color: .clear, location: 1)
                        ]), startPoint: .top, endPoint: .bottom))
                        .frame(height: 100)
                        .edgesIgnoringSafeArea(.top)
                }

                HStack {
                    if let imageUrl = viewModel.show.image?.medium, let url = URL(string: imageUrl) {
                        LazyImage(url: url, resizingMode: .aspectFill)
                            .frame(width: 67.5, height: 100)
                            .cornerRadius(5)
                    }

                    VStack(alignment: .leading) {
                        Text(viewModel.show.name)
                            .lineLimit(1)
                            .font(.title)
                            .fontWeight(.heavy)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineSpacing(4)

                        Text(viewModel.show.genres.joined(separator: " • "))
                            .lineLimit(2)
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.75))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineSpacing(4)

                        Text(viewModel.getRunningDate())
                            .lineLimit(4)
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.75))
                            .frame(maxWidth: .infinity, alignment: .leading)

                    }
                }
                .padding([.top, .horizontal])

                CollapsableText(
                    viewModel.show.summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil),
                    lineLimit: 5
                )

                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.gray)

                    Text(viewModel.getSchedule())
                        .font(.system(size: 14)).bold()
                        .foregroundColor(.gray)
                        .frame(alignment: .leading)
                }

                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.yellow)

                    Text(viewModel.getSubTitle())
                        .font(.system(size: 14)).bold()
                        .foregroundColor(.gray)
                        .frame(alignment: .leading)
                }

                FavoriteButton(isFavorited: viewModel.isFavorited) { isFavorited in
                    isFavorited ? viewModel.removeFromFavorites() : viewModel.addToFavorites()
                }

                LazyVStack {
                    ForEach(viewModel.seasons, id: \.id) { season in
                        DisclosureGroup(
                            content: {
                                ForEach(season.episodes, id: \.id) { episode in
                                    Button {
                                        viewModel.selectedEpisode = episode
                                    } label: {
                                        VStack {
                                            EpisodeRowView(episode: episode)

                                            Divider()
                                        }
                                    }
                                }
                            },

                            label: {
                                HStack {
                                    Image(systemName: "film")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)

                                    Text("Season \(season.id)")
                                        .font(.headline)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)

                                    Spacer()
                                }
                                .padding(.bottom, 8)
                            }
                        )
                        .padding(.horizontal)
                        .accentColor(.black)
                    }
                }
                .padding(.vertical)
            }
        }
        .blur(radius: viewModel.selectedEpisode != nil ? 10 : 0)
        .onAppear {
            viewModel.loadData()
        }
        .sheet(isPresented: .constant(viewModel.selectedEpisode != nil), onDismiss: {
            viewModel.selectedEpisode = nil
        }) {
            if let episode = viewModel.selectedEpisode {
                EpisodeDetailView()
                    .environmentObject(EpisodeDetailViewModel(episode: episode))
                    .presentationDetents(Set(heights))
            }
        }
    }
}

struct ShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailView()
    }
}
