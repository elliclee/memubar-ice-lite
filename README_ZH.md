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

## ❄️ 核心区别与技术升级

* **零外部依赖 (Zero-Dependency)**：完全移除了 Sparkle 自动更新框架以及 Ifrit 模糊搜索引擎。整个项目回归到 100% 原生 Swift/SwiftUI 代码，大幅缩短了编译时间，降低了安装包和内存体积。
* **统一的偏好设置状态管理**：废弃了冗余的 `AdvancedSettingsManager`，将所有偏好设置逻辑合并到单例的 `GeneralSettingsManager` 中。对 `UserDefaults` 的订阅与监听全部集中处理，消除了潜在的响应冲突。
* **现代化 SwiftUI 窗口管理**：升级了 `SettingsWindow` 与 `PermissionsWindow` 场景，全面拥抱 macOS 14+ 原生的 `.windowResizability(.contentSize)` 动态视图自适应机制。
* **像素级侧边栏布局**：在侧边栏中采用自定义 `HStack` 替代默认的 `Label` 组件，成功绕过了 macOS 侧边栏对图标的强制拉伸，实现了像素级精确对齐（`16x16`）。
* **异步授权工作流 (Async/Await)**：将授权等待逻辑重构为基于 Swift 现代并发模型（`async/await` 与 `CheckedContinuation`）的异步工作流，取代了传统复杂的 GCD 轮询，使异步状态管理更加安全且线程安全。
* **精简极致的视觉美学**：重构了原先庞大的授权弹窗，使用 420px 宽度且包含系统磨砂材质、连续圆角和自定义状态徽章卡片的极简界面。

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
