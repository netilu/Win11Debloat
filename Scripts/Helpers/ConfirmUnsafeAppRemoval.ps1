# Shows confirmation dialogs for apps that require extra caution before removal.
# Returns $true if the user confirmed all warnings (or if no warnings were triggered),
# $false if the user declined any warning.
function ConfirmUnsafeAppRemoval {
    param (
        [string[]]$SelectedApps,
        $Owner = $null
    )

    # Skip all warnings in Silent mode
    if ($Silent) {
        return $true
    }

    # Microsoft Store warning
    if ($SelectedApps -contains "Microsoft.WindowsStore") {
        $result = Show-MessageBox -Message '确定要卸载 Microsoft Store 吗？此应用很难重新安装。' -Title '请确认' -Button 'YesNo' -Icon 'Warning' -Owner $Owner

        if ($result -ne 'Yes') {
            return $false
        }
    }

    # Windows Terminal warning
    if ($SelectedApps -contains "Microsoft.WindowsTerminal") {
        $result = Show-MessageBox -Message '确定要移除 Windows 终端吗？Windows 终端是 Windows 的默认命令行应用。继续前请确认 Win11Debloat 不是通过 Windows 终端运行，以免中途失败。' -Title '请确认' -Button 'YesNo' -Icon 'Warning' -Owner $Owner

        if ($result -ne 'Yes') {
            return $false
        }
    }

    return $true
}
