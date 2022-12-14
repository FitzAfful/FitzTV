//
//  ContentView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var biometricViewModel: BiometricViewModel
    @State private var selectedTab = 0

    var body: some View {
        //ZStack {
            if biometricViewModel.isLocked {
                BiometricLockView()

            } else {
                TabView {
                    ShowListView()
                        .tabItem {
                            Label("TV Shows", systemImage: "sparkles.tv")
                            Text("TV Shows")
                        }
                        .tag(0)

                    FavoritesView()
                        .tabItem {
                            Label("Favorites", systemImage: "heart")
                            Text("Favorites")
                        }
                        .tag(1)

                    if biometricViewModel.isSupported {
                        SettingsView()
                            .tabItem {
                                Label("Settings", systemImage: "gearshape")
                                Text("Settings")
                            }
                            .tag(2)
                    }

                }.globalErrorHandler()
            }
       // }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
