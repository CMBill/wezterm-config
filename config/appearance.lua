-- 窗口外观配置
-- 隐藏标题栏，并将窗口控制按钮集成到标签页栏

local wezterm = require 'wezterm'
local colors = require("colors.custom")

local appearance = {
  exit_behavior = "CloseOnCleanExit",
  -- 标签外观
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  integrated_title_button_style = "Windows",
  integrated_title_button_alignment = "Right",
  hide_tab_bar_if_only_one_tab = false,
  tab_max_width = 64,
  -- 光标样式
  default_cursor_style = "BlinkingBar",
  -- 滚动条
  enable_scroll_bar = true,
  -- 配色方案
  color_scheme = colors.color_scheme,
  -- 硬件加速
  animation_fps = 60,
  max_fps = 60,
  -- front_end = 'WebGpu',
  -- webgpu_power_preference = 'HighPerformance',
}

-- for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
--   if gpu.backend == 'Vulkan' and gpu.device_type == 'DiscreteGpu' then
--     appearance.webgpu_preferred_adapter = gpu
--     appearance.front_end = 'WebGpu'
--     break
--   end
-- end

return appearance