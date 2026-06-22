//
//  SettingsView.swift
//  Ice
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var navigationState: AppNavigationState
    @Environment(\.sidebarRowSize) var sidebarRowSize

    private var sidebarWidth: CGFloat {
        switch sidebarRowSize {
        case .small: 160
        case .medium: 175
        case .large: 190
        @unknown default: 175
        }
    }

    private var sidebarItemHeight: CGFloat {
        switch sidebarRowSize {
        case .small: 26
        case .medium: 30
        case .large: 32
        @unknown default: 30
        }
    }

    private var sidebarItemFontSize: CGFloat {
        switch sidebarRowSize {
        case .small: 12
        case .medium: 13
        case .large: 14
        @unknown default: 13
        }
    }

    var body: some View {
        NavigationSplitView {
            sidebar
        } detail: {
            detailView
        }
        .navigationTitle(navigationState.settingsNavigationIdentifier.localized)
    }

    @ViewBuilder
    private var sidebar: some View {
        List(selection: $navigationState.settingsNavigationIdentifier) {
            Section {
                ForEach(SettingsNavigationIdentifier.allCases, id: \.self) { identifier in
                    sidebarItem(for: identifier)
                }
            } header: {
                Text("Ice Lite")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.linearGradient(colors: [.primary, .secondary], startPoint: .top, endPoint: .bottom))
                    .padding(.vertical, 8)
            }
            .collapsible(false)
        }
        .scrollDisabled(true)
        .removeSidebarToggle()
        .navigationSplitViewColumnWidth(sidebarWidth)
    }

    @ViewBuilder
    private var detailView: some View {
        switch navigationState.settingsNavigationIdentifier {
        case .general:
            GeneralSettingsPane()
        case .menuBarLayout:
            MenuBarLayoutSettingsPane()
        case .menuBarAppearance:
            MenuBarAppearanceSettingsPane()
        case .about:
            AboutSettingsPane()
        }
    }

    @ViewBuilder
    private func sidebarItem(for identifier: SettingsNavigationIdentifier) -> some View {
        HStack(spacing: 8) {
            icon(for: identifier).view
                .frame(width: 16, height: 16)
            Text(identifier.localized)
                .font(.system(size: sidebarItemFontSize))
        }
        .frame(height: sidebarItemHeight)
    }

    private func icon(for identifier: SettingsNavigationIdentifier) -> IconResource {
        switch identifier {
        case .general: .systemSymbol("gearshape")
        case .menuBarLayout: .systemSymbol("rectangle.topthird.inset.filled")
        case .menuBarAppearance: .systemSymbol("swatchpalette")
        case .about: .assetCatalog(.iceCubeStroke)
        }
    }
}
