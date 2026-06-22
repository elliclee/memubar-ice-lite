//
//  IceGroupBox.swift
//  Ice
//

import SwiftUI

struct IceGroupBox<Header: View, Content: View, Footer: View>: View {
    private let header: Header
    private let content: Content
    private let footer: Footer
    private let padding: CGFloat

    private var backgroundShape: some InsettableShape {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
    }

    init(
        padding: CGFloat = 10,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) {
        self.padding = padding
        self.header = header()
        self.content = content()
        self.footer = footer()
    }

    init(
        padding: CGFloat = 10,
        @ViewBuilder content: () -> Content,
        @ViewBuilder footer: () -> Footer
    ) where Header == EmptyView {
        self.init(padding: padding) {
            EmptyView()
        } content: {
            content()
        } footer: {
            footer()
        }
    }

    init(
        padding: CGFloat = 10,
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content
    ) where Footer == EmptyView {
        self.init(padding: padding) {
            header()
        } content: {
            content()
        } footer: {
            EmptyView()
        }
    }

    init(
        padding: CGFloat = 10,
        @ViewBuilder content: () -> Content
    ) where Header == EmptyView, Footer == EmptyView {
        self.init(padding: padding) {
            EmptyView()
        } content: {
            content()
        } footer: {
            EmptyView()
        }
    }

    init(
        _ title: LocalizedStringKey,
        padding: CGFloat = 10,
        @ViewBuilder content: () -> Content
    ) where Header == Text, Footer == EmptyView {
        self.init(padding: padding) {
            Text(title)
                .font(.headline)
        } content: {
            content()
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            header
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
                .padding(.leading, 2)
            VStack {
                content
            }
            .padding(padding + 4)
            .background {
                backgroundShape
                    .fill(.regularMaterial)
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 2)
                    .overlay {
                        backgroundShape
                            .strokeBorder(Color.primary.opacity(0.08), lineWidth: 0.5)
                    }
            }
            footer
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
                .padding(.leading, 2)
        }
    }
}
