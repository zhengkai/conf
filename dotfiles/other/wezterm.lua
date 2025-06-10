local wezterm = require 'wezterm'
local config = {}

config.font_size = 14

config.font = wezterm.font 'JetBrains Mono'
config.enable_wayland = false

config.initial_cols = 96
config.initial_rows = 32

local fullscreen = os.getenv("WEZTERM_FULLSCREEN")
if fullscreen == "1" then
	local mux = wezterm.mux
	wezterm.on("gui-startup", function()
		local _, _, window = mux.spawn_window {}
		window:gui_window():toggle_fullscreen()
	end)
	config.default_prog = { '/home/zhengkai/conf/script/tmux-tilda.sh' }
end

config.color_scheme = 'Modus-Vivendi-Deuteranopia'

-- beep
config.colors = {
	visual_bell = '#272727',
}
config.visual_bell = {
	-- target = 'CursorColor',
	fade_in_function = 'EaseIn',
	fade_in_duration_ms = 50,
	fade_out_function = 'EaseOut',
	fade_out_duration_ms = 50,
}
config.audible_bell = "Disabled"

-- 禁用所有标签页功能
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 0
config.hide_tab_bar_if_only_one_tab = true

return config
