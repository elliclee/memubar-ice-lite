//
//  SettingsWindow.swift
//  Ice
//

import SwiftUI

struct SettingsWindow: Scene {
    @ObservedObject var appState: AppState

    var body: some Scene {
        Window(Constants.settingsWindowTitle, id: Constants.settingsWindowID) {
            SettingsView()
                .readWindow { window in
                    guard let window else {
                        return
                    }
                    appState.assignSettingsWindow(window)
                }
                .frame(minWidth: 700, minHeight: 460)
        }
        .commandsRemoved()
        .windowResizability(.contentSize)
        .defaultSize(width: 800, height: 560)
        .environmentObject(appState)
        .environmentObject(appState.navigationState)
    }
}
