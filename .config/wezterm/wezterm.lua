local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.default_prog = { '/Program Files/Powershell/7/pwsh.exe', '-l' }
config.font = wezterm.font 'JetBrains Mono'
config.color_scheme = 'rose-pine-moon'
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  {key="t", mods="CTRL|SHIFT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  {key="w", mods="CTRL|SHIFT", action=wezterm.action{CloseCurrentTab={confirm=true}}},
  {key="h", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=1}},
  {key="l", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=-1}},
}

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

config.keys = {
  -- Switch to the default workspace
  {
    key = 'y',
    mods = 'CTRL|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'default',
    },
  },
  -- Switch to a monitoring workspace, which will have `top` launched into it
  {
    key = 'u',
    mods = 'CTRL|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'monitoring',
      spawn = {
        args = { 'top' },
      },
    },
  },
  -- Create a new workspace with a random name and switch to it
  { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
  -- Show the launcher in fuzzy selection mode and have it list all workspaces
  -- and allow activating one.
  {
    key = 'f',
    mods = 'CTRL',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
}

return config
