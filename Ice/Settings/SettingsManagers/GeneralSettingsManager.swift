//
//  GeneralSettingsManager.swift
//  Ice
//

import Combine
import Foundation

@MainActor
final class GeneralSettingsManager: ObservableObject {
    /// A Boolean value that indicates whether the Ice icon
    /// should be shown.
    @Published var showIceIcon = true

    /// An icon to show in the menu bar, with a different image
    /// for when items are visible or hidden.
    @Published var iceIcon: ControlItemImageSet = .defaultIceIcon

    /// The last user-selected custom Ice icon.
    @Published var lastCustomIceIcon: ControlItemImageSet?

    /// A Boolean value that indicates whether custom Ice icons
    /// should be rendered as template images.
    @Published var customIceIconIsTemplate = false

    /// A Boolean value that indicates whether to show hidden items
    /// in a separate bar below the menu bar.
    @Published var useIceBar = false

    /// The location where the Ice Bar appears.
    @Published var iceBarLocation: IceBarLocation = .dynamic

    /// A Boolean value that indicates whether the hidden section
    /// should be shown when the mouse pointer clicks in an empty
    /// area of the menu bar.
    @Published var showOnClick = true

    /// A Boolean value that indicates whether the hidden section
    /// should be shown when the mouse pointer hovers over an
    /// empty area of the menu bar.
    @Published var showOnHover = false

    /// A Boolean value that indicates whether the hidden section
    /// should be shown or hidden when the user scrolls in the
    /// menu bar.
    @Published var showOnScroll = true

    /// The offset to apply to the menu bar item spacing and padding.
    @Published var itemSpacingOffset: Double = 0

    /// A Boolean value that indicates whether the hidden section
    /// should automatically rehide.
    @Published var autoRehide = true

    /// A strategy that determines how the auto-rehide feature works.
    @Published var rehideStrategy: RehideStrategy = .smart

    /// A time interval for the auto-rehide feature when its rule
    /// is ``RehideStrategy/timed``.
    @Published var rehideInterval: TimeInterval = 15

    /// A Boolean value that indicates whether the application menus
    /// should be hidden if needed to show all menu bar items.
    @Published var hideApplicationMenus = true

    /// A Boolean value that indicates whether section divider control
    /// items should be shown.
    @Published var showSectionDividers = false

    /// A Boolean value that indicates whether the always-hidden section
    /// is enabled.
    @Published var enableAlwaysHiddenSection = false

    /// A Boolean value that indicates whether the always-hidden section
    /// can be toggled by holding down the Option key.
    @Published var canToggleAlwaysHiddenSection = true

    /// The delay before showing on hover.
    @Published var showOnHoverDelay: TimeInterval = 0.2

    /// Time interval to temporarily show items for.
    @Published var tempShowInterval: TimeInterval = 15

    /// A Boolean value that indicates whether to show all sections when
    /// the user is dragging items in the menu bar.
    @Published var showAllSectionsOnUserDrag = true

    @Published var showContextMenuOnRightClick = true

    /// Encoder for properties.
    private let encoder = JSONEncoder()

    /// Decoder for properties.
    private let decoder = JSONDecoder()

    /// Storage for internal observers.
    private var cancellables = Set<AnyCancellable>()

    /// The shared app state.
    private(set) weak var appState: AppState?

    init(appState: AppState) {
        self.appState = appState
    }

    func performSetup() {
        loadInitialState()
        configureCancellables()
    }

    private func loadInitialState() {
        Defaults.ifPresent(key: .showIceIcon, assign: &showIceIcon)
        Defaults.ifPresent(key: .customIceIconIsTemplate, assign: &customIceIconIsTemplate)
        Defaults.ifPresent(key: .useIceBar, assign: &useIceBar)
        Defaults.ifPresent(key: .showOnClick, assign: &showOnClick)
        Defaults.ifPresent(key: .showOnHover, assign: &showOnHover)
        Defaults.ifPresent(key: .showOnScroll, assign: &showOnScroll)
        Defaults.ifPresent(key: .itemSpacingOffset, assign: &itemSpacingOffset)
        Defaults.ifPresent(key: .autoRehide, assign: &autoRehide)
        Defaults.ifPresent(key: .rehideInterval, assign: &rehideInterval)
        Defaults.ifPresent(key: .hideApplicationMenus, assign: &hideApplicationMenus)
        Defaults.ifPresent(key: .showSectionDividers, assign: &showSectionDividers)
        Defaults.ifPresent(key: .enableAlwaysHiddenSection, assign: &enableAlwaysHiddenSection)
        Defaults.ifPresent(key: .canToggleAlwaysHiddenSection, assign: &canToggleAlwaysHiddenSection)
        Defaults.ifPresent(key: .showOnHoverDelay, assign: &showOnHoverDelay)
        Defaults.ifPresent(key: .tempShowInterval, assign: &tempShowInterval)
        Defaults.ifPresent(key: .showAllSectionsOnUserDrag, assign: &showAllSectionsOnUserDrag)
        Defaults.ifPresent(key: .showContextMenuOnRightClick, assign: &showContextMenuOnRightClick)

        Defaults.ifPresent(key: .iceBarLocation) { rawValue in
            if let location = IceBarLocation(rawValue: rawValue) {
                iceBarLocation = location
            }
        }
        Defaults.ifPresent(key: .rehideStrategy) { rawValue in
            if let strategy = RehideStrategy(rawValue: rawValue) {
                rehideStrategy = strategy
            }
        }

        if let data = Defaults.data(forKey: .iceIcon) {
            do {
                iceIcon = try decoder.decode(ControlItemImageSet.self, from: data)
            } catch {
                Logger.generalSettingsManager.error("Error decoding Ice icon: \(error)")
            }
            if case .custom = iceIcon.name {
                lastCustomIceIcon = iceIcon
            }
        }
    }

    private func configureCancellables() {
        var c = Set<AnyCancellable>()

        $showIceIcon
            .receive(on: DispatchQueue.main)
            .sink { showIceIcon in
                Defaults.set(showIceIcon, forKey: .showIceIcon)
            }
            .store(in: &c)

        $iceIcon
            .receive(on: DispatchQueue.main)
            .sink { [weak self] iceIcon in
                guard let self else {
                    return
                }
                if case .custom = iceIcon.name {
                    lastCustomIceIcon = iceIcon
                }
                do {
                    let data = try encoder.encode(iceIcon)
                    Defaults.set(data, forKey: .iceIcon)
                } catch {
                    Logger.generalSettingsManager.error("Error encoding Ice icon: \(error)")
                }
            }
            .store(in: &c)

        $customIceIconIsTemplate
            .receive(on: DispatchQueue.main)
            .sink { isTemplate in
                Defaults.set(isTemplate, forKey: .customIceIconIsTemplate)
            }
            .store(in: &c)

        $useIceBar
            .receive(on: DispatchQueue.main)
            .sink { useIceBar in
                Defaults.set(useIceBar, forKey: .useIceBar)
            }
            .store(in: &c)

        $iceBarLocation
            .receive(on: DispatchQueue.main)
            .sink { location in
                Defaults.set(location.rawValue, forKey: .iceBarLocation)
            }
            .store(in: &c)

        $showOnClick
            .receive(on: DispatchQueue.main)
            .sink { showOnClick in
                Defaults.set(showOnClick, forKey: .showOnClick)
            }
            .store(in: &c)

        $showOnHover
            .receive(on: DispatchQueue.main)
            .sink { showOnHover in
                Defaults.set(showOnHover, forKey: .showOnHover)
            }
            .store(in: &c)

        $showOnScroll
            .receive(on: DispatchQueue.main)
            .sink { showOnScroll in
                Defaults.set(showOnScroll, forKey: .showOnScroll)
            }
            .store(in: &c)

        $itemSpacingOffset
            .receive(on: DispatchQueue.main)
            .sink { [weak appState] offset in
                Defaults.set(offset, forKey: .itemSpacingOffset)
                appState?.spacingManager.offset = Int(offset)
            }
            .store(in: &c)

        $autoRehide
            .receive(on: DispatchQueue.main)
            .sink { autoRehide in
                Defaults.set(autoRehide, forKey: .autoRehide)
            }
            .store(in: &c)

        $rehideStrategy
            .receive(on: DispatchQueue.main)
            .sink { strategy in
                Defaults.set(strategy.rawValue, forKey: .rehideStrategy)
            }
            .store(in: &c)

        $rehideInterval
            .receive(on: DispatchQueue.main)
            .sink { interval in
                Defaults.set(interval, forKey: .rehideInterval)
            }
            .store(in: &c)

        $hideApplicationMenus
            .receive(on: DispatchQueue.main)
            .sink { shouldHide in
                Defaults.set(shouldHide, forKey: .hideApplicationMenus)
            }
            .store(in: &c)

        $showSectionDividers
            .receive(on: DispatchQueue.main)
            .sink { shouldShow in
                Defaults.set(shouldShow, forKey: .showSectionDividers)
            }
            .store(in: &c)

        $enableAlwaysHiddenSection
            .receive(on: DispatchQueue.main)
            .sink { enable in
                Defaults.set(enable, forKey: .enableAlwaysHiddenSection)
            }
            .store(in: &c)

        $canToggleAlwaysHiddenSection
            .receive(on: DispatchQueue.main)
            .sink { canToggle in
                Defaults.set(canToggle, forKey: .canToggleAlwaysHiddenSection)
            }
            .store(in: &c)

        $showOnHoverDelay
            .receive(on: DispatchQueue.main)
            .sink { delay in
                Defaults.set(delay, forKey: .showOnHoverDelay)
            }
            .store(in: &c)

        $tempShowInterval
            .receive(on: DispatchQueue.main)
            .sink { interval in
                Defaults.set(interval, forKey: .tempShowInterval)
            }
            .store(in: &c)

        $showAllSectionsOnUserDrag
            .receive(on: DispatchQueue.main)
            .sink { showAll in
                Defaults.set(showAll, forKey: .showAllSectionsOnUserDrag)
            }
            .store(in: &c)

        $showContextMenuOnRightClick
            .receive(on: DispatchQueue.main)
            .sink { showAll in
                Defaults.set(showAll, forKey: .showContextMenuOnRightClick)
            }
            .store(in: &c)

        cancellables = c
    }
}

// MARK: GeneralSettingsManager: BindingExposable
extension GeneralSettingsManager: BindingExposable { }

// MARK: - Logger
private extension Logger {
    static let generalSettingsManager = Logger(category: "GeneralSettingsManager")
}
