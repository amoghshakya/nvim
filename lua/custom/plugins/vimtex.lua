--[[
-- Vimtex is a Vim plugin for editing LaTeX files. It provides features like syntax highlighting, folding, and more.
-- This file contains all the configurations for the Vimtex plugin and some additional plugins that enhance LaTeX editing in Neovim.
--]]

return {
  {
    "lervag/vimtex",
    ft = { "tex", "latex", "plaintex" },
    lazy = false,
    -- Custom configuration goes here
    config = function()
      -- vim.g.vimtex_view_method = "zathura_simple"

      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_view_sioyek_options = "--reuse-window"

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
  { -- This is for grammar and spell checking
    "barreiroleo/ltex_extra.nvim",
    ft = { "tex", "latex" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
