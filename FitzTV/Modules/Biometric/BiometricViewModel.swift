//
//  BiometricViewModel.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import SwiftUI
import Valet

@MainActor class BiometricViewModel: ObservableObject {
    var biometricHelper = BiometricHelper()

    @Published private(set) var isSupported: Bool
    @Published var isEnabled: Bool {
        didSet {
            if oldValue != isEnabled {
                if isEnabled {
                    Task {
                        await enable()
                    }
                } else {
                    disable()
                }
            }
        }
    }

    @Published var isLocked: Bool = false
    private var authenticating = false

    init() {
        isSupported = BiometricHelper().isSupported
        do {
            let data = try Valet.biometric.object(forKey: ValetKeys.biometricLockEnabled)
            isEnabled = try JSONDecoder().decode(Bool.self, from: data)
        } catch {
            debugPrint("Retrieving Biometric lock threw error: \(error.localizedDescription)")
            isEnabled = false
        }
    }

    func lockIfEnabled() {
        if isEnabled && !authenticating {
            isLocked = true
        }
    }

    func unlock() {
        withAnimation {
            isLocked = false
        }
    }

    func enable() async {
        do {
            authenticating = true
            let authenticated = try await biometricHelper.authenticateBiometric()
            if authenticated {
                setEnabled(bool: true)
            }
            authenticating = false
        } catch {
            guard let bioError = error.asBiometricError() else {
                error.raiseGlobalAlert()
                return
            }
            bioError.raiseGlobalAlert()
        }
    }

    func disable() {
        setEnabled(bool: false)
    }

    func authenticate() async {
        do {
            assert(isLocked)
            let authenticated = try await biometricHelper.authenticateBiometric()
            if authenticated {
                unlock()
            }
        } catch {
            guard let bioError = error.asBiometricError() else {
                error.raiseGlobalAlert()
                return
            }

            if bioError  == .authenticationCancelled {
                return
            }

            bioError.raiseGlobalAlert()
        }
    }

    private func setEnabled(bool: Bool) {
        do {
            let boolData = try JSONEncoder().encode(bool)
            try Valet.biometric.setObject(boolData, forKey: ValetKeys.biometricLockEnabled)
        } catch {
            error.raiseGlobalAlert()
        }
    }
}
