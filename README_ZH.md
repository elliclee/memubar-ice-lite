<div align="center">
    <img src="Ice/Assets.xcassets/AppIcon.appiconset/icon_256x256.png" width=160 height=160>
    <h1>Ice Lite</h1>
    <p>一个现代化、轻量且紧凑的 macOS 14+ 菜单栏管理器</p>
    <p>
        <a href="README.md">English</a> | <b>简体中文</b>
    </p>
</div>

**Ice Lite** 是优秀开源项目 [jordanbaird/Ice](https://github.com/jordanbaird/Ice) 的一个简化、高度优化和视觉现代化的分支版本。

本分支的目标是创建一个极简、专注于核心菜单栏管理的单功能实用工具，移除冗余模块和外部依赖，同时引入紧凑、精致的 macOS 原生设计语言。

---

## ❄️ 核心区别与优化

* **无依赖核心**：移除了模糊搜索引擎和 Sparkle 自动更新框架，降低了应用复杂度，消除了外部 Swift Package Manager (SPM) 依赖包。
* **精简的设置界面**：将设置精简为四个清爽的面板：通用 (General)、菜单栏布局 (Menu Bar Layout)、菜单栏外观 (Menu Bar Appearance) 以及关于 (About)。移除了原有的快捷键 (Hotkeys) 和高级设置 (Advanced) 面板。
* **现代化排版与间距**：优化并缩小了所有窗口度量、布局元素和字体字号，能更完美地契合 macOS Sonoma 和 Sequoia 的精致设计。
* **重新设计的授权面板**：用现代、紧凑的卡片式引导界面代替了原先臃肿的弹窗，轻松引导用户完成辅助功能 (Accessibility) 和屏幕录制 (Screen Recording) 权限的授予。
* **全新品牌视觉**：包含量身定制的 3D 水晶玻璃冰块应用图标，以及相匹配的极简菜单栏控制图标。

---

## 🛠️ 功能特性

### 菜单栏图标管理
- [x] 隐藏菜单栏图标
- [x] “总是隐藏”菜单栏区域
- [x] 鼠标悬停在菜单栏时显示隐藏的图标
- [x] 点击菜单栏空白区域时显示隐藏的图标
- [x] 在菜单栏滑动或滚动以切换隐藏的图标
- [x] 自动重新隐藏菜单栏图标
- [x] 拖拽排列单个菜单栏图标的界面
- [x] 在独立控制栏中显示隐藏的图标 (适用于带刘海屏的 MacBook)
- [x] 菜单栏图标间距调整 (BETA)

### 菜单栏外观定制
- [x] 菜单栏着色（单色与渐变）
- [x] 菜单栏阴影
- [x] 菜单栏边框
- [x] 自定义菜单栏形状（圆角/分段式）

### 核心系统集成
- [x] 开机自启
- [x] 本地完整签名运行

---

## 🚀 如何在本地运行

### 运行环境
* macOS 14.0 或更高版本
* Xcode 15.0 或更高版本

### 构建与运行
1. 克隆仓库：
   ```sh
   git clone https://github.com/elliclee/memubar-ice-lite.git
   cd memubar-ice-lite
   ```
2. 在 Xcode 中打开 `Ice.xcodeproj`。
3. 选择 **Ice** scheme，然后按 `Cmd + R` 运行，或者使用以下命令编译 Release 版本：
   ```sh
   xcodebuild -scheme Ice -configuration Release -destination 'platform=macOS' -derivedDataPath ./build CODE_SIGN_IDENTITY="-" DEVELOPMENT_TEAM=""
   ```

---

## 📜 致谢与开源协议

Ice Lite 基于 Jordan Baird 创建的开源项目 [Ice](https://github.com/jordanbaird/Ice)。我们非常感谢他们的工作。

Ice Lite 同样基于 **GPL-3.0 协议** 开源（与上游主项目保持一致）。详情请参阅 [LICENSE](LICENSE) 文件。
