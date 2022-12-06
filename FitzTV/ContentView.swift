//
//  ContentView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 03/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView {
            ShowListView()
                .tabItem {
                    Label("TV Shows", systemImage: "sparkles.tv")
                    Text("TV Shows")
                }
                .tag(0)


            PasscodeField(handler: { code, completion in
                print("Code: \(code)")
            })
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                    Text("Favorites")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                    Text("Settings")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
