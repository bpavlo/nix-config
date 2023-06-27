local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end
config.window_close_confirmation = 'NeverPrompt'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 16
config.front_end = 'WebGpu'
config.use_fancy_tab_bar = true
config.window_decorations = 'RESIZE'
config.cursor_blink_rate = 0
config.window_frame = {
  font = wezterm.font { family = 'JetBrains Mono', weight = 'Regular' },
  font_size = 14,
  active_titlebar_bg = '#002b36',
  inactive_titlebar_bg = '#073642',
}

config.colors = {
  ansi = {
    '#073642',
    '#dc322f',
    '#859900',
    '#b58900',
    '#268bd2',
    '#d33682',
    '#2aa198',
    '#eee8d5',
  },
  background = '#002b36',
  brights = {
      '#002b36',
      '#cb4b16',
      '#586e75',
      '#657b83',
      '#839496',
      '#6c71c4',
      '#93a1a1',
      '#fdf6e3',
  },
  cursor_bg = '#839496',
  cursor_border = '#839496',
  cursor_fg = '#073642',
  foreground = '#839496',
  selection_bg = '#073642',
  selection_fg = '#93a1a1',
  tab_bar = {
    active_tab = {
      bg_color = '#002b36',
      fg_color = '#859900',
    },
    inactive_tab = {
      bg_color = '#073642',
      fg_color = '#93a1a1',
    },
    inactive_tab_hover = {
      bg_color = '#002b36',
      fg_color = '#93a1a1',
    },
    new_tab = {
      bg_color = '#073642',
      fg_color = '#b58900',
    },
    new_tab_hover = {
      bg_color = '#002b36',
      fg_color = '#93a1a1',
    },
  },
}

return config
