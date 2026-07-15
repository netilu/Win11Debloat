# 如何参与贡献？

欢迎社区参与 Win11Debloat。你可以通过以下方式提供帮助：

- [报告问题和错误](https://github.com/Raphire/Win11Debloat/issues/new?template=bug_report.yml)
- [提出功能建议](https://github.com/Raphire/Win11Debloat/issues/new?template=feature_request.yml)
- 测试 Win11Debloat
- 创建拉取请求（Pull Request）
- 改进文档

# 测试 Win11Debloat

你可以帮助测试脚本的最新更改和新增功能。如遇问题，请提交[错误报告](https://github.com/Raphire/Win11Debloat/issues/new?template=bug_report.yml)。

> [!WARNING]
> Win11Debloat 预发布版本仅供开发者测试，请勿用于生产环境。

运行以下命令可启动预发布版本：

```ps1
& ([scriptblock]::Create((irm "https://debloat.raphi.re/"))) -Dev
```

# 贡献代码

## 开始之前

### Fork 并克隆仓库

1. 在 GitHub 仓库页面右上角单击“Fork”。
2. 将仓库克隆到本地：

   ```powershell
   git clone https://github.com/YOUR-USERNAME/Win11Debloat.git
   cd Win11Debloat
   ```

3. 为本次更改创建分支：

   ```powershell
   git checkout -b feature/your-feature-name
   ```

### 在本地运行脚本

1. 以管理员身份打开 PowerShell。
2. 如有需要，为当前进程启用脚本执行：

   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process -Force
   ```

3. 进入 Win11Debloat 目录。
4. 运行脚本：

   ```powershell
   .\Win11Debloat.ps1
   ```

## 实现指南

### 项目结构

```text
Win11Debloat/
├── Win11Debloat.ps1             # 主 PowerShell 脚本
├── Run.bat                      # 快速启动批处理文件
├── Scripts/                     # PowerShell 脚本和函数
│   ├── Get.ps1                  # 下载并运行 Win11Debloat 的快速启动脚本
│   ├── AppRemoval/              # 应用包移除逻辑
│   ├── CLI/                     # 命令行界面辅助函数
│   ├── Features/                # 功能应用和撤销逻辑
│   ├── FileIO/                  # 文件输入输出辅助函数
│   ├── GUI/                     # 图形界面定义和逻辑
│   ├── Helpers/                 # 通用辅助函数
│   └── Threading/               # 线程工具
├── Config/
│   ├── Apps.json                # 支持移除的应用列表
│   ├── DefaultSettings.json     # 默认配置预设
│   ├── Features.json            # 功能及其元数据
│   └── LastUsedSettings.json    # 最近一次配置（运行时生成）
├── Regfiles/                    # 各项功能使用的注册表文件
│   ├── Undo/                    # 撤销功能的注册表文件
│   └── Sysprep/                 # Sysprep 模式注册表文件
├── Schemas/                     # 图形界面的 XAML 文件
├── Assets/                      # 图标和开始菜单模板等静态资源
├── Backups/                     # 注册表备份（运行时生成）
└── Logs/                        # 脚本日志（运行时生成）
```

### 最佳实践

1. 在 Windows 测试环境中充分测试更改，包括撤销调整、其他用户模式和 Sysprep 模式。
2. 同步更新 `README.md` 和其他相关文档。Wiki 会根据 `Features.json` 和 `Apps.json` 生成或更新。
3. 参考现有实现并遵循项目已有模式。
4. 为功能、ID 和注册表文件使用清晰、易懂的名称。
5. 仅修改必要的注册表项，并尽量避免使用策略项。
6. 为复杂 PowerShell 逻辑添加说明原因的注释。
7. 仅适用于特定 Windows 版本的功能应设置 `MinVersion` 和 `MaxVersion`。
8. 每个拉取请求只包含一项功能，以便审查。

### 代码风格

- PowerShell 脚本使用 4 个空格缩进。
- JSON 文件使用 2 个空格缩进。
- 遵循现有命名约定，并使用有意义的变量名。
- 控制行宽，尽量将嵌套限制在 4 至 5 层以内。
- 图标使用 [Segoe Fluent Icon Assets](https://learn.microsoft.com/windows/apps/design/iconography/segoe-fluent-icons-font)。

### 常见问题

1. **忘记更新 `Get.ps1`**：新增命令行参数时，必须同时更新 `Win11Debloat.ps1` 和 `Scripts/Get.ps1`。
2. **缺少注册表文件**：功能通常需要正常、`Undo` 和 `Sysprep` 三类注册表文件。
3. **Sysprep 配置单元错误**：Sysprep 文件中的 `HKEY_CURRENT_USER` 应改为 `hkey_users\default`，并确保所有相关键都已修改。
4. **文件位置错误**：正常操作放在 `Regfiles/`，撤销文件放在 `Regfiles/Undo/`，Sysprep 文件放在 `Regfiles/Sysprep/`。
5. **未测试撤销**：确认撤销注册表文件能够恢复全部更改。
6. **未测试其他用户或 Sysprep**：确认功能可应用到其他用户和 Windows 默认用户；运行 Sysprep 更改后可新建用户进行测试。
7. **缺少分类**：`Category` 为 `null` 的功能不会出现在图形界面中，这只适合纯命令行功能。
8. **硬编码路径**：使用 `$PSScriptRoot` 和脚本变量，确保脚本可从任意安装目录运行。

## 实现新功能

### 添加可移除应用

> [!NOTE]
> 图形界面会根据 `Apps.json` 自动生成应用选项。

1. 查找应用的 AppId：

   ```powershell
   Get-AppxPackage | Select-Object Name, PackageFullName
   ```

2. 在 `Config/Apps.json` 的 `Apps` 数组中添加条目：

   ```json
   {
     "FriendlyName": "显示名称",
     "AppId": "AppPackageIdentifier",
     "Description": "应用的简要说明",
     "SelectedByDefault": false,
     "Recommendation": "optional",
     "RemovalMethod": "Appx"
   }
   ```

字段说明：

- `FriendlyName`：图形界面中显示的名称。
- `AppId`：来自 `Get-AppxPackage` 的包标识，或来自 `winget list` 的 `Id`。
- `Description`：图形界面中显示的应用简介。
- `SelectedByDefault`：仅对普遍认为是冗余软件的应用设为 `true`。
- `Recommendation`：移除建议级别，可选 `safe`、`optional` 或 `unsafe`。
- `RemovalMethod`：移除方式。大多数应用使用 `Appx`；非 Appx 应用可使用 `WinGet`。

### 添加功能

功能在 `Config/Features.json` 中定义，可通过注册表文件或 PowerShell 命令修改 Windows 设置。

> [!NOTE]
> 仅修改注册表的简单功能通常不需要改动主逻辑，但仍需添加相应的命令行参数。图形界面会根据 `Features.json` 自动生成。

#### 1. 创建注册表文件

- 应用文件：`Regfiles/Disable_YourFeature.reg`
- 撤销文件：`Regfiles/Undo/Enable_YourFeature.reg`
- Sysprep 文件：`Regfiles/Sysprep/Disable_YourFeature.reg`

示例：

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\YourPath]
"SettingName"=dword:00000000
```

Sysprep 文件应执行同样的更改，但将 `HKEY_CURRENT_USER` 替换为 `hkey_users\default`。

如果功能不只是导入注册表文件，请在 `Scripts/Features/InvokeChanges.ps1` 的 `Invoke-FeatureApply` 中添加应用逻辑；需要自定义撤销时，同时更新 `Invoke-FeatureUndo`。

#### 2. 更新 `Features.json`

在 `Features` 数组中添加功能：

```json
{
  "FeatureId": "YourFeatureId",
  "Label": "功能的简短名称",
  "ToolTip": "功能作用和影响的详细说明。",
  "Category": "隐私和建议内容",
  "Priority": 1,
  "RegistryKey": "Disable_YourFeature.reg",
  "ApplyText": "正在应用：功能名称",
  "UndoLabel": "撤销功能的简短说明",
  "ApplyUndoText": "正在撤销：功能名称",
  "RegistryUndoKey": "Enable_YourFeature.reg",
  "RequiresReboot": false,
  "DisableWhenApplied": false,
  "MinVersion": null,
  "MaxVersion": null
}
```

关键字段：

- `FeatureId`：唯一标识，必须与 `Win11Debloat.ps1` 和 `Get.ps1` 中的参数名一致。
- `Label`、`ToolTip`：图形界面和 Wiki 中显示的名称与说明。
- `Category`：`Categories` 数组中预定义的分类；没有分类的功能不会载入图形界面。
- `Priority`：可选的分类内排序值。
- `RegistryKey`、`RegistryUndoKey`：应用和撤销所用的注册表文件名；不需要时设为 `null`。
- `RequiresReboot`：功能是否需要重启才能生效。
- `DisableWhenApplied`：没有受支持撤销方式时设为 `true`。
- `MinVersion`、`MaxVersion`：适用的最小和最大 Windows 版本。

#### 3. 添加命令行参数

在 `Win11Debloat.ps1` 和 `Scripts/Get.ps1` 中添加同名参数，通常为：

```powershell
[switch]$YourFeatureId,
```

### 将功能加入默认预设

> [!IMPORTANT]
> 默认预设应保持保守。只有经过充分测试、普遍有益且易于撤销的功能才应加入。

在 `Config/DefaultSettings.json` 的 `Settings` 数组中添加：

```json
{
  "Name": "YourFeatureId",
  "Value": true
}
```

### 添加分类

在 `Config/Features.json` 的 `Categories` 数组中添加：

```json
{
  "Name": "分类名称",
  "Icon": "&#xE####;"
}
```

图标代码请参考 [Segoe Fluent Icon Assets](https://learn.microsoft.com/windows/apps/design/iconography/segoe-fluent-icons-font)。

### 添加界面选项组

界面选项组可将多个功能组合为下拉选项：

```json
{
  "GroupId": "UniqueGroupId",
  "Label": "选项组名称",
  "ToolTip": "选项组控制内容的说明",
  "Category": "分类名称",
  "Priority": 1,
  "Values": [
    {
      "Label": "选项 1",
      "FeatureIds": ["FeatureId1"]
    },
    {
      "Label": "选项 2",
      "FeatureIds": ["FeatureId2"]
    }
  ]
}
```

## 提交拉取请求

1. 使用清晰的提交消息提交更改：

   ```powershell
   git add .
   git commit -m "Add feature: Description of your changes"
   ```

2. 推送到你的 Fork：

   ```powershell
   git push origin feature/your-feature-name
   ```

3. 在 GitHub 上创建 Pull Request，选择你的 Fork 和分支，并说明更改内容及涉及的注册表项，同时关联相关 Issue。
4. 根据代码审查反馈继续调整。

# 有疑问？

- 发起[讨论](https://github.com/Raphire/Win11Debloat/discussions)
- 在现有 Issue 下留言
- 在你的 Pull Request 中提问
