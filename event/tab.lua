-- 标签页标题配置
-- 自定义 format-tab-title 事件，显示进程名、管理员标识及未读输出提示

local wezterm = require('wezterm')

local nf = wezterm.nerdfonts

-- 图标：盾牌（管理员标识）
local GLYPH_ADMIN = nf.md_shield_half_full

local M = {}

-- 渲染标签页时使用的格式化单元格列表
local __cells__ = {}

-- 固定装饰部分占用宽度：尾随空格 = 1
local DECOR_BASE = 1
-- 管理员图标额外占用：图标(1) + 空格(1) = 2
local DECOR_ADMIN = 2

-- 不同状态下的标签页颜色（默认 / 激活）
local colors = {
   default   = { bg = '#45475a', fg = '#cdd6f4' },
   is_active = { bg = '#89b4fa', fg = '#1e1e2e' },
}

-- 从进程路径中提取进程名，并去掉 .exe 后缀
local _set_process_name = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

-- 拼接标签页标题：进程名 + 基础标题
local _set_title = function(process_name, base_title)
   if process_name:len() > 0 then
      return process_name .. ' : ' .. base_title
   end
   return base_title
end

-- 判断当前标签页是否以管理员身份运行
local _check_if_admin = function(p)
   if p:match('^Administrator: ') then
      return true
   end
   return false
end

-- 将标题文本截断到指定宽度（扣除装饰部分），超长末尾加 …
local function _truncate_title(title, is_admin, max_width)
   local decor = DECOR_BASE + (is_admin and DECOR_ADMIN or 0)
   local available = max_width - decor
   local char_len = utf8.len(title)
   if available >= char_len then
      return title
   end
   if available <= 1 then
      return ''
   end
   local byte_cut = utf8.offset(title, available)
   if byte_cut then
      return string.sub(title, 1, byte_cut - 1) .. '…'
   end
   return title
end

-- 向单元格列表追加一段带样式的文本
local _push = function(bg, fg, attribute, text)
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Attribute = attribute })
   table.insert(__cells__, { Text = text })
end

-- 注册 format-tab-title 事件，返回自定义格式化的标签页标题
M.setup = function()
   wezterm.on('format-tab-title', function(tab, tabs, _panes, _config, hover, max_width)
      __cells__ = {}

      local bg
      local fg
      local process_name = _set_process_name(tab.active_pane.foreground_process_name)
      local is_admin = _check_if_admin(tab.active_pane.title)
      local title = _set_title(process_name, tab.active_pane.title)

      title = _truncate_title(title, is_admin, max_width)

      -- 根据标签页状态选择对应颜色
      if tab.is_active then
         bg = colors.is_active.bg
         fg = colors.is_active.fg
      else
         bg = colors.default.bg
         fg = colors.default.fg
      end

      -- 管理员标识图标
      if is_admin then
         _push(bg, fg, { Intensity = 'Bold' }, GLYPH_ADMIN .. ' ')
      end

      _push(bg, fg, { Intensity = 'Bold' }, title)

      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      return __cells__
   end)
end

return M
