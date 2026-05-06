-- 配置管理模块
-- 统一加载 config/ 文件夹内的所有子模块

local M = {
  fonts = require("config.fonts"),
  appearance = require("config.appearance"),
  keys = require("config.keys"),
}

-- 合并配置的方法
function M.merge(cfg, colors)
    local config = {
        font = require("wezterm").font_with_fallback(cfg.fonts.font_list),
        font_size = cfg.fonts.size,
        line_height = cfg.fonts.line_height,
        default_prog = { "pwsh" },
    }

    if colors.color_scheme then
        config.color_scheme = colors.color_scheme
    end

    if cfg.appearance then
        for key, value in pairs(cfg.appearance) do
            config[key] = value
        end
    end

    if cfg.keys then
        for key, value in pairs(cfg.keys) do
            config[key] = value
        end
    end

    return config
end

return M
