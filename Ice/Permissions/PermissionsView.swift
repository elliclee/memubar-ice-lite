//
//  PermissionsView.swift
//  Ice
//

import SwiftUI

struct PermissionsView: View {
    @EnvironmentObject var permissionsManager: PermissionsManager
    @Environment(\.openWindow) private var openWindow

    private var continueButtonText: LocalizedStringKey {
        if case .hasRequiredPermissions = permissionsManager.permissionsState {
            "Continue in Limited Mode"
        } else {
            "Continue"
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            headerView

            permissionsGroupStack

            footerView
        }
        .padding(20)
        .frame(width: 420)
        .readWindow { window in
            guard let window else {
                return
            }
            window.styleMask.remove([.closable, .miniaturizable])
            if let contentView = window.contentView {
                with(contentView.safeAreaInsets) { insets in
                    insets.bottom = -insets.bottom
                    insets.left = -insets.left
                    insets.right = -insets.right
                    insets.top = -insets.top
                    contentView.additionalSafeAreaInsets = insets
                }
            }
        }
    }

    @ViewBuilder
    private var headerView: some View {
        VStack(spacing: 12) {
            if let nsImage = NSImage(named: "AppIcon") {
                Image(nsImage: nsImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 56, height: 56)
                    .shadow(color: Color.black.opacity(0.12), radius: 6, x: 0, y: 3)
            }

            VStack(spacing: 4) {
                Text("Welcome to Ice Lite")
                    .font(.system(size: 18, weight: .bold, design: .rounded))

                Text("Ice Lite needs permission to manage your menu bar.\nNo personal data is ever collected or stored.")
                    .font(.system(size: 11.5))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, 4)
    }

    @ViewBuilder
    private var permissionsGroupStack: some View {
        VStack(spacing: 10) {
            ForEach(permissionsManager.allPermissions) { permission in
                permissionBox(permission)
            }
        }
    }

    @ViewBuilder
    private var footerView: some View {
        HStack(spacing: 12) {
            quitButton
            continueButton
        }
        .controlSize(.regular)
    }

    @ViewBuilder
    private var quitButton: some View {
        Button(role: .cancel) {
            NSApp.terminate(nil)
        } label: {
            Text("Quit")
                .frame(maxWidth: .infinity)
        }
        .keyboardShortcut(.cancelAction)
    }

    @ViewBuilder
    private var continueButton: some View {
        Button {
            guard let appState = permissionsManager.appState else {
                return
            }
            appState.performSetup()
            appState.permissionsWindow?.close()
            appState.appDelegate?.openSettingsWindow()
        } label: {
            Text(continueButtonText)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .disabled(permissionsManager.permissionsState == .missingPermissions)
        .keyboardShortcut(.defaultAction)
    }

    @ViewBuilder
    private func permissionBox(_ permission: Permission) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: permission.hasPermission ? "checkmark.circle.fill" : "circle.dotted")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(permission.hasPermission ? Color.green : Color.secondary.opacity(0.6))
                    .frame(width: 24, height: 24)

                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Text(permission.title)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.primary)

                        Text(permission.isRequired ? "Required" : "Optional")
                            .font(.system(size: 9, weight: .semibold))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 1.5)
                            .background(
                                Capsule()
                                    .fill(permission.isRequired ? Color.red.opacity(0.12) : Color.blue.opacity(0.12))
                            )
                            .foregroundStyle(permission.isRequired ? Color.red.opacity(0.9) : Color.blue.opacity(0.9))
                    }

                    VStack(alignment: .leading, spacing: 1) {
                        ForEach(permission.details, id: \.self) { detail in
                            Text("• \(detail)")
                                .font(.system(size: 10.5))
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                Spacer()

                Button {
                    guard let appState = permissionsManager.appState else {
                        return
                    }
                    permission.performRequest()
                    Task {
                        await permission.waitForPermission()
                        appState.activate(withPolicy: .regular)
                        openWindow(id: Constants.permissionsWindowID)
                    }
                } label: {
                    Text(permission.hasPermission ? "Granted" : "Grant")
                        .font(.system(size: 11, weight: .medium))
                        .frame(width: 56)
                }
                .buttonStyle(.borderedProminent)
                .tint(permission.hasPermission ? Color.green.opacity(0.15) : Color.blue)
                .foregroundStyle(permission.hasPermission ? Color.green : Color.white)
                .allowsHitTesting(!permission.hasPermission)
            }
            .padding(12)

            if !permission.isRequired && !permission.hasPermission {
                Divider()
                    .opacity(0.5)
                HStack(spacing: 4) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                    Text("Ice Lite can run in limited mode without this permission.")
                        .font(.system(size: 9.5))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.regularMaterial)
                .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.primary.opacity(0.08), lineWidth: 0.5)
                )
        )
    }
}
