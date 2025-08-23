--[[
-- https://github.com/folke/snacks.nvim
-- A collection of QoL plugins for Neovim (Thank you folke!)
--]]

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = {
      easing = "outCubic",
    },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    dashboard = require("core.configs.snacks").dashboard,
    explorer = require("core.configs.snacks").explorer,
    indent = {
      enabled = true,
    },
    image = {
      enabled = true,
      math = {
        enabled = true,
      },
    },
    input = { enabled = true },
    lazygit = {
      enabled = true,
    },
    notifier = {
      enabled = true,
    },
    picker = require("core.configs.snacks").picker,
    quickfile = {
      enabled = true,
      exclude = { "latex" },
    },
    rename = { enabled = true },
    scope = { enabled = true },
    statuscolumn = {
      enabled = true,
    },
    terminal = require("core.configs.snacks").terminal,
    toggle = { which_key = true },
    words = { enabled = true },
  },
  keys = require("core.configs.snacks").keys,
}
