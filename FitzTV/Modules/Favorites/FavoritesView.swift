//
//  FavoritesView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel = FavoritesViewModel()
    @State var selectedHouse: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.isLoading {
                    Spacer()
                    ActivityIndicator()
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.shows) { show in
                            NavigationLink {
                                ShowDetailView()
                                    .environmentObject(ShowDetailViewModel(show: show))
                            } label: {
                                ShowRowView(show: show)
                            }
                        }
                    }
                    .padding(.top, 64)
                }

            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("FitzTV")
                    }
                }

                ToolbarItem {
                    NavigationLink(
                        destination: SearchView(),
                        label: { Label("Search", systemImage: "magnifyingglass") }
                    )
                }
            }
            .onAppear {
                viewModel.loadData()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
