//
//  ValetKeys.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import Foundation
import Valet

struct ValetKeys {
    // Biometric lock key
    static let biometricLockEnabled = "biometricLockEnabled"
}

extension Valet {
    /// Contains biometric credentials
    static var biometric: Valet {
        Valet.valet(
            with: Identifier(nonEmpty: ValetKeys.biometricLockEnabled)!,
            accessibility: .whenUnlocked
        )
    }
}
