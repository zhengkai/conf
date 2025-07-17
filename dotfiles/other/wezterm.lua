local wezterm = require 'wezterm'
local config = {}

config.warn_about_missing_glyphs = false
config.font_size = 14

config.font = wezterm.font_with_fallback({
	{ family = 'JetBrains Mono NL', },
	{ family = 'Source Han Sans SC', },
	{ family = 'Symbols Nerd Font', }
})
config.font_rules = {
	{
		intensity = 'Half',
		italic = false,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono NL ExtraLight', },
			{ family = 'Source Han Sans SC ExtraLight', },
			{ family = 'Symbols Nerd Font', }
		}),
	},
	{
		intensity = 'Half',
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono NL ExtraLight',  italic = true, },
			{ family = 'Source Han Sans SC ExtraLight', italic = true, },
			{ family = 'Symbols Nerd Font', }
		}),
	},
	{
		intensity = 'Bold',
		italic = false,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono NL ExtraBold', },
			{ family = 'Source Han Sans SC Heavy', },
			{ family = 'Symbols Nerd Font', }
		}),
	},
	{
		intensity = 'Bold',
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono NL ExtraBold', italic = true, },
			{ family = 'Source Han Sans SC Heavy',    italic = true, },
			{ family = 'Symbols Nerd Font', }
		}),
	},
	{
		intensity = 'Normal',
		italic = true,
		font = wezterm.font_with_fallback({
			{ family = 'JetBrains Mono NL',  italic = true, },
			{ family = 'Source Han Sans SC', italic = true, },
			{ family = 'Symbols Nerd Font', }
		}),
	},
}
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.enable_wayland = false

config.set_environment_variables = {
	GTK_IM_MODULE = "fcitx",
	QT_IM_MODULE = "fcitx",
	XMODIFIERS = "@im=fcitx",
	GLFW_IM_MODULE = "fcitx",
	INPUT_METHOD = "fcitx",
}

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

-- https://wezterm.org/colorschemes/index.html
config.color_scheme = 'Tango (terminal.sexy)'
config.color_schemes = {
	['Tango (terminal.sexy)'] = {
		-- background = '#000000',
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

-- config.debug_key_events = true

config.disable_default_key_bindings = true
config.keys = {
	{ key = 'v',     mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = "Space", mods = "CTRL",       action = 'Nop' },
}
return config
