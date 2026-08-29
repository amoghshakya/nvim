local base = require("catppuccin.palettes.mocha")

local M = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#c4a7e7",
  -- red = "#eb6f92",
  maroon = "#eba0ac",
  -- peach = "#f6c177",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  text = "#e0def4",
  subtext1 = "#908caa",
  subtext0 = "#a6adc8",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6e6a86",
  surface2 = "#524f67",
  surface1 = "#403d52",
  surface0 = "#21202e",
  base = "#191724",
  mantle = "#13101b",
  crust = "#0b0b12",
}

return vim.tbl_deep_extend("force", base, M)
