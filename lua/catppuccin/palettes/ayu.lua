local base = require("catppuccin.palettes.mocha")

local M = {
  base = "#10141C",
  mantle = "#0D1017",
  crust = "#05070A",

  text = "#BFBDB6",
  subtext1 = "#A6A49C",
  subtext0 = "#8C8A82",

  overlay2 = "#667381",
  overlay1 = "#636A72",
  overlay0 = "#5A6673",

  surface2 = "#4D5763",
  surface1 = "#333B44",
  surface0 = "#161A24",

  blue = "#59C2FF",
  sapphire = "#39BAE6",
  sky = "#95E6CB",
  teal = "#84CEB5",
  green = "#AAD94C",

  yellow = "#FFB454",
  peach = "#FF8F40",

  maroon = "#F07178",
  flamingo = "#E6B450",

  red = "#D95757",

  mauve = "#D2A6FF",
  pink = "#F29668",
  lavender = "#DAB8FF",
  rosewater = "#E6C08A",
}

return vim.tbl_deep_extend("force", base, M)
