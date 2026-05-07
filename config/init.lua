-- 配置管理模块
-- 统一加载 config/ 文件夹内的所有子模块

local M = {
  fonts = require("config.fonts"),
  appearance = require("config.appearance"),
  keymaps = require("config.keymaps"),
  launcher = require("config.launcher"),
}

-- 合并配置的方法
function M.merge(cfg)
    local config = {
        font = require("wezterm").font_with_fallback(cfg.fonts.font_list),
        font_size = cfg.fonts.size,
        line_height = cfg.fonts.line_height,
        default_prog = { "pwsh" },
    }

    if cfg.appearance then
        for key, value in pairs(cfg.appearance) do
            config[key] = value
        end
    end

    if cfg.keymaps then
        for k, value in pairs(cfg.keymaps) do
            config[k] = value
        end
    end

    if cfg.launcher then
        for k, value in pairs(cfg.launcher) do
            config[k] = value
        end
    end

    return config
end

return M
