//
//  SearchView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @State var selectedHouse: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    SearchField(searchText: $viewModel.searchText)
                        .frame(maxHeight: 50)
                        .padding(8)
                        .listRowInsets(EdgeInsets())
                        .frame(maxWidth: .infinity, minHeight: 60)

                    ForEach(viewModel.searchResults) { show in
                        NavigationLink {

                        } label: {
                            ShowRowView(show: show)
                        }
                    }
                }
                .padding(.top, 64)
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
