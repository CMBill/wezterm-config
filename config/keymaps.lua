-- 快捷键配置

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
    -- Ctrl+Shift+C -> 复制到剪贴板
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo "Clipboard" },
    -- Ctrl+Shift+V -> 从剪贴板粘贴
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom "Clipboard" },
    -- Alt+n -> 新建标签页
    { key = "n", mods = "ALT", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
    -- Alt+w -> 关闭当前标签页
    { key = "w", mods = "ALT", action = wezterm.action.CloseCurrentTab { confirm = true } },
    -- Alt+j -> 切换到左侧标签页
    { key = "j", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
    -- Alt+k -> 切换到右侧标签页
    { key = "k", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
  },
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = wezterm.action_callback(function(window, pane)
        local has_selection = window:get_selection_text_for_pane(pane) ~= ""
        if has_selection then
          window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
          window:perform_action(wezterm.action.ClearSelection, pane)
        else
          window:perform_action(wezterm.action.PasteFrom("Clipboard"), pane)
        end
      end),
    },
  },
}

return keys
