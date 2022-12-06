//
//  BiometricHelper.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 06/12/2022.
//

import Foundation
import LocalAuthentication

protocol LAContextProtocol {
    func canEvaluatePolicy(_: LAPolicy, error: NSErrorPointer) -> Bool
    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void)
}

extension LAContext: LAContextProtocol {}

class BiometricHelper {
    private var context: LAContextProtocol
    private var error: NSError?

    init(context: LAContextProtocol = LAContext() ) {
        self.context = context
    }

    // If device supports biometric authentication
    // Note: on Pro simulators, this kept returning false
    var isSupported: Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    func authenticateBiometric() async throws -> Bool {
        let reason = "Please verify your identity to unlock FitzTV."
        return try await withCheckedThrowingContinuation({ cont in
            self.context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { result, error in
                if let error = error { return cont.resume(throwing: error) }
                cont.resume(returning: result)

                self.context = LAContext()
            }
        })
    }
}

extension Error {
    func asBiometricError() -> BiometricError? {
        switch self {
        case LAError.appCancel, LAError.systemCancel, LAError.userCancel:
            return BiometricError.authenticationCancelled
        case LAError.passcodeNotSet, LAError.biometryNotEnrolled:
            return BiometricError.biometricNotSetup
        case LAError.biometryNotAvailable:
            return BiometricError.biometricNotSupported
        case LAError.userFallback, LAError.authenticationFailed:
            return BiometricError.authenticationFailed
        default:
            return nil
        }
    }
}

enum BiometricError: Error {
    case biometricNotSupported
    case biometricNotSetup
    case authenticationFailed
    case authenticationCancelled
}

extension BiometricError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .biometricNotSupported:
            return """
            Unlocking this app with face recognition or fingerprint \
            is unfortunately not supported on this device.
            """
        case .biometricNotSetup:
            return """
                First setup your device to (un)lock through face recognition or a fingerprint\n\n
                Then return to add this extra layer of security
                """
        case .authenticationFailed:
            return "Authenticating user failed. Please try again"
        case .authenticationCancelled:
            return "Biometric authentication cancelled"
        }
    }
}
