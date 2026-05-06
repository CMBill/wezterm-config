-- 标签页标题配置
-- 自定义 format-tab-title 事件，显示进程名、管理员标识及未读输出提示

local wezterm = require('wezterm')

local nf = wezterm.nerdfonts

-- 图标：圆点（未读输出指示）和盾牌（管理员标识）
local GLYPH_CIRCLE = nf.fa_circle
local GLYPH_ADMIN = nf.md_shield_half_full

local M = {}

-- 渲染标签页时使用的格式化单元格列表
local __cells__ = {}

-- 不同状态下的标签页颜色（默认 / 激活 / 悬停）
local colors = {
   default   = { bg = '#45475a', fg = '#cdd6f4' },
   is_active = { bg = '#89b4fa', fg = '#1e1e2e' },
   hover     = { bg = '#585b70', fg = '#cdd6f4' },
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

-- 向单元格列表追加一段带样式的文本
local _push = function(bg, fg, attribute, text)
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Attribute = attribute })
   table.insert(__cells__, { Text = text })
end

-- 注册 format-tab-title 事件，返回自定义格式化的标签页标题
M.setup = function()
   wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
      __cells__ = {}

      local bg
      local fg
      local process_name = _set_process_name(tab.active_pane.foreground_process_name)
      local is_admin = _check_if_admin(tab.active_pane.title)
      local title = _set_title(process_name, tab.active_pane.title)

      -- 根据标签页状态选择对应颜色
      if tab.is_active then
         bg = colors.is_active.bg
         fg = colors.is_active.fg
      elseif hover then
         bg = colors.hover.bg
         fg = colors.hover.fg
      else
         bg = colors.default.bg
         fg = colors.default.fg
      end

      -- 检测该标签页下是否有窗格存在未读输出
      local has_unseen_output = false
      for _, pane in ipairs(tab.panes) do
         if pane.has_unseen_output then
            has_unseen_output = true
            break
         end
      end

      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      -- 管理员标识图标
      if is_admin then
         _push(bg, fg, { Intensity = 'Bold' }, GLYPH_ADMIN .. ' ')
      end

      _push(bg, fg, { Intensity = 'Bold' }, title)

      -- 未读输出用橙色圆点，已读用绿色圆点
      if has_unseen_output then
         _push(bg, '#FFA066', { Intensity = 'Bold' }, ' ' .. GLYPH_CIRCLE)
      else
         _push(bg, '#00A066', { Intensity = 'Bold' }, ' ' .. GLYPH_CIRCLE)
      end

      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      return __cells__
   end)
end

return M
