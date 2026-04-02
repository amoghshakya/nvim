--[[
-- A very fast plugin for highlighting colors in files.
-- -- This plugin is useful for quickly identifying colors in code files, especially in CSS and HTML files.
--]]

return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    -- ignore following filetypes
    filetypes = {
      "*",
      "!lazy",
    },
    lazy_load = true,
    options = {
      parsers = {
        css = true,
        css_fn = true, -- rgb, hsl, oklch
        tailwind = {
          enable = true,
          update_names = true,
          lsp = {
            enable = true,
          },
        },
        sass = { enable = true },
        hex = { enable = true },
      },
      display = {
        mode = "background",
        virtualtext = {
          char = "",
          position = "before",
        },
      },
    },
  },
}
