--[[
-- Vimtex is a Vim plugin for editing LaTeX files. It provides features like syntax highlighting, folding, and more.
-- This file contains all the configurations for the Vimtex plugin and some additional plugins that enhance LaTeX editing in Neovim.
--]]

return {
  {
    "lervag/vimtex",
    lazy = false,
    -- Custom configuration goes here
    config = function()
      -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } }
      vim.g.vimtex_view_method = "zathura_simple"

      vim.g.vimtex_quickfix_autoclose_after_keystrokes = 25

      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        build_dir = "out",
        aux_dir = "out",
        options = {
          "-synctex=1",
          "-shell-escape",
        },
      }
    end,
  },
}
