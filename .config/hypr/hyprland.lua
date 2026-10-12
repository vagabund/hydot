-- Точка входа конфига Hyprland (Lua, 0.55+).
-- Каждый require выполняется в своей области видимости: ошибка в одном файле
-- не ломает остальные. Общие переменные лежат в programs.lua.

require("env")
require("autostart")
require("permissions")
require("lookandfeel")
require("animations")
require("input")
require("keybindings")
require("workspaces")
require("layerrules")
