//
//  ErrorView.swift
//  FitzTV
//
//  Created by Fitzgerald Afful on 04/12/2022.
//

import SwiftUI


struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button?
    var primaryButton: Alert.Button?
    var secondaryButton: Alert.Button?

    /// Should be by SwiftUI to render the actual Alert
    func toAlert() -> Alert {
        if let dismissButton = dismissButton {
            return Alert(
                title: title,
                message: message,
                dismissButton: dismissButton
            )
        } else if let primaryButton = primaryButton,
                  let secondaryButton = secondaryButton {
            return Alert(
                title: title,
                message: message,
                primaryButton: primaryButton,
                secondaryButton: secondaryButton
            )
        } else {
            return Alert(title: Text("⚠️ An unkown error occured"))
        }
    }

    /// Posts this AlertItem through NotificationCenter, so any subscribed view
    /// can render the alert.
    func post() {
        NotificationCenter.default.post(name: .globalError, object: self)
    }
}

struct GlobalErrorHandler: ViewModifier {
    @State var globalAlertItem: AlertItem?

    func body(content: Content) -> some View {
        content
            // Error handling: same as in ContentView for the main app
            .alert(item: $globalAlertItem) { alertItem in
                alertItem.toAlert()
            }
            /// Use this to easily present alert's based on any error
            .onReceive(NotificationCenter.default.publisher(for: .globalError)) { notification in
                /// If a predefined alert item is passed, present that
                if let alertItem = notification.object as? AlertItem {
                    globalAlertItem = alertItem
                }
                /// If an error is passed, create a generic alert item
                else if let error = notification.object as? Error {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.globalAlertItem = AlertItem(
                            title: Text("Something went wrong"),
                            message: Text(error.localizedDescription),
                            dismissButton: .default(Text("Ok"))
                        )
                    }
                }
            }
    }
}

extension View {
    func globalErrorHandler() -> some View {
        return self.modifier(GlobalErrorHandler())
    }
}

extension Error {
    /// Post this error to the global error handler, which raises an alert item
    func raiseGlobalAlert() {
        Task { @MainActor in
            NotificationCenter.default.post(name: .globalError, object: self)
        }
    }
}

extension Notification.Name {
    static let globalError = Notification.Name("globalError")
}
