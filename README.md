<div align="center">
    <img src="Ice/Assets.xcassets/AppIcon.appiconset/icon_256x256.png" width=160 height=160>
    <h1>Ice Lite</h1>
    <p>A modernized, lightweight, and compact menu bar manager for macOS 14+</p>
    <p>
        <b>English</b> | <a href="README_ZH.md">简体中文</a>
    </p>
</div>

**Ice Lite** is a simplified, highly optimized, and visually modernized fork of the excellent open-source project [jordanbaird/Ice](https://github.com/jordanbaird/Ice). 

The goal of this fork is to create an extremely streamlined, single-purpose utility focused entirely on essential menu bar management, stripping away redundant modules and external dependencies while introducing a compact, premium native macOS visual language.

---

## ❄️ Key Differences & Optimizations

* **Dependency-Free Core**: Removed fuzzy search engines and the Sparkle auto-update framework, reducing app complexity and eliminating external SPM packages.
* **Streamlined Settings UI**: Consolidated settings into four clean panes: General, Menu Bar Layout, Menu Bar Appearance, and About (removed complex Hotkeys and Advanced settings panels).
* **Modernized Typography & Spacing**: Made all window metrics, layout elements, and text sizes compact. Fits natively and beautifully alongside macOS Sonoma & Sequoia designs.
* **Redesigned Permissions Flow**: Replacing standard dialogs with a modern, compact, and card-based onboarding view that guides users through Accessibility and Screen Recording options.
* **Brand Assets**: Custom 3D crystal glass ice cube application icon and matching minimalist menu bar indicators.

---

## 🛠️ Features

### Menu Bar Item Management
- [x] Hide menu bar items
- [x] "Always-hidden" menu bar section
- [x] Show hidden menu bar items when hovering over the menu bar
- [x] Show hidden menu bar items when an empty area in the menu bar is clicked
- [x] Show hidden menu bar items by scrolling or swiping in the menu bar
- [x] Automatically rehide menu bar items
- [x] Drag and drop interface to arrange individual menu bar items
- [x] Display hidden menu bar items in a separate bar (e.g. for MacBooks with the notch)
- [x] Menu bar item spacing (BETA)

### Menu Bar Appearance
- [x] Menu bar tint (solid and gradient)
- [x] Menu bar shadow
- [x] Menu bar border
- [x] Custom menu bar shapes (rounded and/or split)

### Core Integration
- [x] Launch at login
- [x] Fully signed to run locally

---

## 🚀 How to Run Locally

### Requirements
* macOS 14.0 or later
* Xcode 15.0 or later

### Build & Run
1. Clone the repository:
   ```sh
   git clone https://github.com/elliclee/memubar-ice-lite.git
   cd memubar-ice-lite
   ```
2. Open `Ice.xcodeproj` in Xcode.
3. Select the **Ice** scheme and press `Cmd + R` to run, or compile a release version using:
   ```sh
   xcodebuild -scheme Ice -configuration Release -destination 'platform=macOS' -derivedDataPath ./build CODE_SIGN_IDENTITY="-" DEVELOPMENT_TEAM=""
   ```

---

## 📜 Acknowledgements & License

Ice Lite is based on [Ice](https://github.com/jordanbaird/Ice) created by Jordan Baird. We are incredibly grateful for their work.

Ice Lite is released under the **GPL-3.0 License** (same as the original upstream project). See [LICENSE](LICENSE) for details.
