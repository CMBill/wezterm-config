-- 快捷键配置
-- Alt+/ 水平拆分，Alt+方向键 在窗格间导航

local wezterm = require("wezterm")

local keys = {
  keys = {
    -- Alt+/ -> 水平拆分
    { key = "/", mods = "ALT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    -- Alt+左箭头 -> 向左切换窗格
    { key = "LeftArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Left" },
    -- Alt+右箭头 -> 向右切换窗格
    { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Right" },
    -- Alt+上箭头 -> 向上切换窗格
    { key = "UpArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Up" },
    -- Alt+下箭头 -> 向下切换窗格
    { key = "DownArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Down" },
    -- Alt+\ -> 垂直拆分（下方）
    { key = "\\", mods = "ALT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    -- Alt+Shift+左箭头 -> 向左增大窗格
    { key = "LeftArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize { "Left", 3 } },
    -- Alt+Shift+右箭头 -> 向右增大窗格
    { key = "RightArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize { "Right", 3 } },
    -- Alt+Shift+上箭头 -> 向上增大窗格
    { key = "UpArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize { "Up", 3 } },
    -- Alt+Shift+下箭头 -> 向下增大窗格
    { key = "DownArrow", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize { "Down", 3 } },
    -- Alt+x -> 关闭当前窗格
    { key = "x", mods = "ALT", action = wezterm.action.CloseCurrentPane { confirm = true } },
  },
}

return keys
