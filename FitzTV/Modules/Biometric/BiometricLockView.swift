//
//  BiometricLockView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import Foundation
import SwiftUI

struct BiometricLockView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var viewModel: BiometricViewModel

    var displayLogo = true

    var body: some View {
        VStack(alignment: .center, spacing: 0) {

            Spacer()

            Button {
                Task { await viewModel.authenticate() }
            } label: {
                Text("Unlock app")
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(20)
        .onAppear {
            Task { await viewModel.authenticate() }
        }
    }
}
