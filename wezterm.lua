-- WezTerm 主配置文件
-- config/ 目录下的配置由 config/init.lua 统一加载
-- 其他目录下的配置在此直接加载

local cfg = require("config.init")
local colors = require("colors.custom")

cfg.tab.setup()

return cfg.merge(cfg, colors)
