local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_close_confirmation = 'NeverPrompt'
config.font = wezterm.font 'FiraMono Nerd Font'
config.font_size = 16
config.front_end = 'WebGpu'
config.use_fancy_tab_bar = true
config.window_decorations = 'RESIZE'
config.cursor_blink_rate = 0
config.window_frame = {
  font = wezterm.font { family = 'FiraMono Nerd Font', weight = 'Bold' },
  font_size = 14,
}

config.color_scheme = 'Solarized Dark - Patched'

return config
