-- 窗口外观配置
-- 隐藏标题栏，并将窗口控制按钮集成到标签页栏

local appearance = {
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  integrated_title_button_style = "Windows",
  integrated_title_button_alignment = "Right",
  hide_tab_bar_if_only_one_tab = false,
}

return appearance