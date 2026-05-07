-- WezTerm 主配置文件
-- config/ 目录下的配置由 config/init.lua 统一加载
-- event/ 目录下的事件监听在此直接加载

local cfg = require("config.init")
local colors = require("colors.custom")
local tab_event = require("event.tab")

tab_event.setup()

return cfg.merge(cfg, colors)
