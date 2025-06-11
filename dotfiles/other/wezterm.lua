local wezterm = require 'wezterm'
local config = {}

config.font_size = 14

config.font = wezterm.font_with_fallback({
	{ family = 'JetBrains Mono', },
	{ family = 'Source Han Sans SC', },
})
config.font_rules = {
	{
		intensity = 'Half',
		italic = false,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono ExtraLight', },
			{ family = 'Source Han Sans SC ExtraLight', },
		}),
	},
	{
		intensity = 'Half',
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono ExtraLight',     italic = true, },
			{ family = 'Source Han Sans SC ExtraLight', italic = true, },
		}),
	},
	{
		intensity = 'Bold',
		italic = false,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono ExtraBold', },
			{ family = 'Source Han Sans SC Heavy', },
		}),
	},
	{
		intensity = 'Bold',
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono ExtraBold', italic = true, },
			{ family = 'Source Han Sans SC Heavy', italic = true, },
		}),
	},
	{
		intensity = 'Normal',
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono',     italic = true, },
			{ family = 'Source Han Sans SC', italic = true, },
		}),
	},
}
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.fallback_fonts = {
	'Symbols Nerd Font',
}

config.enable_wayland = false

config.initial_cols = 96
config.initial_rows = 32

-- fullscreen
local fullscreen = os.getenv('WEZTERM_FULLSCREEN')
if fullscreen == '1' then
	local mux = wezterm.mux
	wezterm.on('gui-startup', function()
		local _, _, window = mux.spawn_window {}
		window:gui_window():toggle_fullscreen()
	end)
	config.default_prog = { '/home/zhengkai/conf/script/tmux-tilda.sh' }
end

config.color_scheme = 'Apple System Colors'

config.color_schemes = {
	['Apple System Colors'] = {
		background = '#000000',
	},
}

-- beep
config.colors = {
	visual_bell = '#272727',
}
config.visual_bell = {
	fade_in_function = 'EaseIn',
	fade_in_duration_ms = 50,
	fade_out_function = 'EaseOut',
	fade_out_duration_ms = 50,
}
config.audible_bell = 'Disabled'

-- disable all 'tab' features
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 0
config.hide_tab_bar_if_only_one_tab = true

return config
