--[[
-- I like catppuccin because it integrates well with other plugins and has a nice color palette.
-- Sometimes I just get sick of the blue and want something different.
-- This file includes some color overrides for the catppuccin colorscheme.
--]]

local M = {}

-- Gruvbox Hard
M.gruvbox = {
  dark = {
    rosewater = "#ea6962",
    flamingo = "#ea6962",
    pink = "#d3869b",
    red = "#ea6962",
    maroon = "#ea6962",
    mauve = "#d3869b",
    peach = "#e78a4e",
    yellow = "#d8a657",
    green = "#a9b665",
    teal = "#89b482",
    sky = "#89b482",
    sapphire = "#89b482",
    blue = "#7daea3",
    lavender = "#7daea3",
    text = "#ebdbb2",
    subtext1 = "#d5c4a1",
    subtext0 = "#bdae93",
    overlay2 = "#a89984",
    overlay1 = "#928374",
    overlay0 = "#595959",
    surface2 = "#4d4d4d",
    surface1 = "#404040",
    surface0 = "#292929",
    base = "#1d2021",
    mantle = "#191b1c",
    crust = "#141617",
  },
  light = {
    rosewater = "#c14a4a",
    flamingo = "#c14a4a",
    red = "#c14a4a",
    maroon = "#c14a4a",
    pink = "#945e80",
    mauve = "#945e80",
    peach = "#c35e0a",
    yellow = "#b47109",
    green = "#6c782e",
    teal = "#4c7a5d",
    sky = "#4c7a5d",
    sapphire = "#4c7a5d",
    blue = "#45707a",
    lavender = "#45707a",
    text = "#654735",
    subtext1 = "#73503c",
    subtext0 = "#805942",
    overlay2 = "#8c6249",
    overlay1 = "#8c856d",
    overlay0 = "#a69d81",
    surface2 = "#bfb695",
    surface1 = "#d1c7a3",
    surface0 = "#e3dec3",
    base = "#f9f5d7",
    mantle = "#f0ebce",
    crust = "#e8e3c8",
  },
}

M.rosepine = {
  dark = {
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
  },
}

-- https://github.com/ember-theme/ember/blob/main/palette.json
M.ember = {
  ember = {
    rosewater = "#f2b5a0",
    flamingo = "#e89377",
    pink = "#b07878",
    mauve = "#988090",
    red = "#e08060",
    maroon = "#a65a4a",

    peach = "#c09058",
    yellow = "#c8b468",

    green = "#8a9868",
    teal = "#80a090",
    sky = "#95afc0",
    sapphire = "#7890a0",
    blue = "#5d7687",
    lavender = "#b8b0a0",

    text = "#d8d0c0",
    subtext1 = "#c2baa9",
    subtext0 = "#aca493",
    overlay2 = "#8e8779",
    overlay1 = "#756f63",
    overlay0 = "#5c574d",

    surface2 = "#3b3935",
    surface1 = "#2e2c29",
    surface0 = "#242320",
    base = "#1c1b19",
    mantle = "#161513",
    crust = "#11100f",
  },
}

M.ayu = {
  dark = {
    base = "#0B0E14",
    mantle = "#0F131A",
    crust = "#05070A",

    text = "#BFBDB6",
    subtext1 = "#A6A49C",
    subtext0 = "#8C8A82",

    overlay2 = "#6E747D",
    overlay1 = "#636A72",
    overlay0 = "#565B66",

    surface2 = "#3C414A",
    surface1 = "#1E222A",
    surface0 = "#11151C",

    blue = "#59C2FF",
    sapphire = "#39BAE6",
    sky = "#95E6CB",
    teal = "#7FDBCA",

    yellow = "#FFB454",
    peach = "#FF8F40",

    maroon = "#F07178",
    flamingo = "#F29668",

    mauve = "#D2A6FF",
    rosewater = "#E6B673",

    red = "#D95757",
  },
}

return M
