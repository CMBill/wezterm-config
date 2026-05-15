-- 启动器菜单配置
-- 根据系统平台提供不同的启动项

local wezterm = require("wezterm")

local function is_windows()
  return wezterm.target_triple:find("windows") ~= nil
end

local launcher = {}

if is_windows() then
  launcher.launch_menu = {
    {
      label = "PowerShell",
      args = { "powershell.exe" },
    },
    {
      label = "PowerShell 7 (pwsh)",
      args = { "pwsh.exe" },
    },
    {
      label = "Git Bash",
      args = { "C:\\Program Files\\Git\\bin\\bash.exe", "-l" },
    },
    {
      label = "CMD",
      args = { "cmd.exe" },
    },
    {
      label = "Arch Linux (WSL)",
      args = { "wsl.exe", "-d", "archlinux" },
    },
  }
else
  launcher.launch_menu = {
    {
      label = "Zsh",
      args = { "/bin/zsh" },
    },
    {
      label = "Bash",
      args = { "/bin/bash" },
    },
  }
end

return launcher
