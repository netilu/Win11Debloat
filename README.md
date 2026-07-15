# Win11Debloat

[![GitHub 最新版本](https://img.shields.io/github/v/release/Raphire/Win11Debloat?style=for-the-badge&label=%E6%9C%80%E6%96%B0%E7%89%88%E6%9C%AC)](https://github.com/Raphire/Win11Debloat/releases/latest)
[![参与讨论](https://img.shields.io/badge/%E5%8F%82%E4%B8%8E%E8%AE%A8%E8%AE%BA-2D9F2D?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Raphire/Win11Debloat/discussions)
[![文档](https://img.shields.io/badge/%E6%96%87%E6%A1%A3-_?style=for-the-badge&logo=bookstack&color=grey)](https://github.com/Raphire/Win11Debloat/wiki/)

Win11Debloat 是一个轻量、易用的 PowerShell 脚本，无需安装即可快速精简和自定义 Windows。它可以移除预装应用、禁用遥测、去除干扰性界面元素等，让你不必逐项翻找设置或逐个卸载应用。

脚本还提供了适合系统管理员和高级用户的功能，包括功能完整的命令行界面、Windows 审核模式支持，以及为其他 Windows 用户应用更改。你也可以方便地导入和导出偏好设置，从而在多台设备上快速应用相同配置。更多信息请参阅项目 [Wiki](https://github.com/Raphire/Win11Debloat/wiki)。

#### 如果这个脚本对你有帮助，欢迎请作者喝杯咖啡以支持项目维护

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/M4M5C6UPC)

## 使用方法

> [!Warning]
> 项目已尽力确保脚本不会意外破坏操作系统功能，但请自行承担使用风险。如果遇到问题，请在[这里](https://github.com/Raphire/Win11Debloat/issues)报告。

### 快速方法

通过 PowerShell 自动下载并运行脚本。

1. 打开 PowerShell 或终端。
2. 将以下命令复制并粘贴到 PowerShell：

```PowerShell
& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
```

3. 等待脚本自动下载并启动 Win11Debloat。
4. 仔细阅读并按照屏幕提示操作。

此方法支持命令行参数，可用于自定义脚本行为。更多信息请参阅 [Wiki 中的命令行界面说明](https://github.com/Raphire/Win11Debloat/wiki/Command%E2%80%90line-Interface#parameters)。

### 传统方法

<details>
  <summary>手动下载并运行脚本</summary><br/>

  1. [下载最新版本](https://github.com/Raphire/Win11Debloat/releases/latest)，并将 ZIP 文件解压到所需位置。
  2. 打开 Win11Debloat 文件夹。
  3. 双击 `Run.bat` 启动脚本。如果控制台窗口立即关闭且没有任何反应，请尝试下方的高级方法。
  4. 接受 Windows UAC 提示，以管理员身份运行脚本；这是脚本正常工作所必需的。
  5. 仔细阅读并按照屏幕提示操作。
</details>

### 高级方法

<details>
  <summary>手动下载脚本，并通过 PowerShell 运行。推荐高级用户使用</summary><br/>

  1. [下载最新版本](https://github.com/Raphire/Win11Debloat/releases/latest)，并将 ZIP 文件解压到所需位置。
  2. 以管理员身份打开 PowerShell 或终端。
  3. 输入以下命令，临时允许 PowerShell 执行脚本：

  ```PowerShell
  Set-ExecutionPolicy Unrestricted -Scope Process -Force
  ```

  4. 在 PowerShell 中进入解压后的目录，例如：`cd c:\Win11Debloat`。
  5. 输入以下命令运行脚本：

  ```PowerShell
  .\Win11Debloat.ps1
  ```

  6. 仔细阅读并按照屏幕提示操作。

  此方法支持命令行参数，可用于自定义脚本行为。更多信息请参阅 [Wiki 中的命令行界面说明](https://github.com/Raphire/Win11Debloat/wiki/Command%E2%80%90line-Interface#parameters)。
</details>

## 功能

以下是 Win11Debloat 主要功能的概览。详细说明请参阅项目 [Wiki](https://github.com/Raphire/Win11Debloat/wiki)。

> [!Tip]
> Win11Debloat 所做的更改都可以方便地还原，绝大多数应用也可以通过 Microsoft Store 重新安装。还原方法请参阅 [Wiki](https://github.com/Raphire/Win11Debloat/wiki/Reverting-Changes)。

#### 应用移除

- 移除多种预装应用。更多信息请参阅[应用移除说明](https://github.com/Raphire/Win11Debloat/wiki/App-Removal)。

#### 隐私和建议内容

- 禁用遥测、诊断数据、活动历史记录、应用启动跟踪和定向广告。
- 禁用 Windows、锁屏界面和 Microsoft Edge 中的提示、技巧、建议和广告。
- 禁用 Windows 定位服务、应用位置访问和“查找我的设备”位置跟踪。
- 隐藏“设置”主页中的 Microsoft 365 广告，或完全隐藏“主页”页面。

#### AI 功能

- 禁用并移除 Microsoft Copilot、Windows 回顾和“单击即做”。
- 阻止 AI 服务（WSAIFabricSvc）自动启动。
- 禁用 Edge、画图和记事本中的 AI 功能。

#### 系统

- 禁用用于共享和移动文件的“拖动托盘”。
- 恢复经典 Windows 10 风格的右键菜单。
- 关闭“提高指针精确度”（鼠标加速）。
- 禁用粘滞键键盘快捷键。
- 禁用存储感知自动磁盘清理。
- 禁用快速启动，确保完整关机。
- 禁用 BitLocker 自动设备加密。
- 禁用现代待机期间的网络连接以减少耗电。

#### Windows 更新

- 阻止 Windows 第一时间获取可用更新。
- 阻止登录期间在更新后自动重启。
- 禁用与其他电脑共享已下载的更新（传递优化）。
- 阻止 Windows 自动安装设备配套应用。

#### 外观

- 为系统和应用启用深色模式。
- 禁用透明、动画和视觉效果。

#### 开始菜单和搜索

- 移除固定应用、隐藏推荐内容，并自定义“所有应用”区域。
- 禁用开始菜单中的“手机连接”移动设备集成。
- 禁用 Windows 搜索中的 Bing 网页搜索、Copilot 集成和 Microsoft Store 应用建议。

#### 任务栏

- 更改任务栏对齐方式。
- 自定义或隐藏搜索栏、任务视图等任务栏按钮。
- 禁用任务栏和锁屏界面上的小组件。
- 在任务栏右键菜单中启用“结束任务”，以便快速强制关闭应用。
- 启用任务栏应用的“上次活动窗口单击”行为，重复点击应用图标即可在该应用打开的窗口之间切换。
- 自定义任务栏应用按钮的显示方式。

#### 文件资源管理器

- 更改文件资源管理器默认打开的位置。
- 显示已知文件类型的扩展名。
- 显示隐藏的文件、文件夹和驱动器。
- 在导航窗格中隐藏主页、图库或 OneDrive。
- 隐藏导航窗格中重复的可移动驱动器条目，只保留“此电脑”下的条目。
- 将桌面、下载等常用文件夹重新添加到“此电脑”。
- 更改驱动器号的位置或可见性。

#### 多任务

- 禁用窗口贴靠。
- 禁用贴靠窗口时的贴靠助手和贴靠布局建议。
- 更改贴靠窗口或按 Alt+Tab 时是否显示应用标签页。

#### Windows 可选功能

- 启用 Windows 沙盒，在隔离的轻量桌面环境中安全运行应用。
- 启用适用于 Linux 的 Windows 子系统，直接在 Windows 上运行 Linux 环境。

#### 其他

- 禁用 Xbox Game Bar 集成和游戏/屏幕录制。如果卸载 Xbox Game Bar，也会阻止 `ms-gamingoverlay` 和 `ms-gamebar` 弹窗。
- 禁用 Brave 浏览器中的 AI、加密货币、新闻等奖励和推广功能。

#### 高级功能

- [将更改应用到其他用户](https://github.com/Raphire/Win11Debloat/wiki/Advanced-Features#running-as-another-user)，而不只是当前登录用户。
- 使用 [Sysprep 模式](https://github.com/Raphire/Win11Debloat/wiki/Advanced-Features#sysprep-mode)将更改应用到 Windows 默认用户配置文件，使之后创建的新用户自动获得相同设置。

## 参与贡献

欢迎各种形式的贡献！有关入门方式和最佳实践，请参阅[贡献指南](https://github.com/Raphire/Win11Debloat/blob/master/.github/CONTRIBUTING.md)。

## 许可证

Win11Debloat 使用 MIT 许可证。详细信息请参阅 LICENSE 文件。
