//
//  SettingsView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var biometricViewModel: BiometricViewModel

    var body: some View {
        NavigationView {
            VStack {
                BiometricLockToggleView()
                    .padding()

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("FitzTV")
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
