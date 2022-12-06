//
//  BiometricToggleView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import SwiftUI

struct BiometricLockToggleView: View {
    @EnvironmentObject var viewModel: BiometricViewModel

    var body: some View {
        Toggle(isOn: $viewModel.isEnabled) {
            HStack {
                Text("Enable Biometric Lock")
                    .font(.system(size: 14))
                    .padding(.trailing)

                Spacer()
            }
        }
    }
}

struct BiometricToggleView_Previews: PreviewProvider {
    static var previews: some View {
        BiometricLockToggleView()
    }
}
