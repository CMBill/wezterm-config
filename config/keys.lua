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
  },
}

return keys
