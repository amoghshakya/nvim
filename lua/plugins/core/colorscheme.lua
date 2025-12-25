return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- Ensure it loads first
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha or auto
      default_integrations = true,
      auto_integrations = true,
      color_overrides = {
        -- mocha = require("configs.colorscheme").gruvbox.dark, -- custom overrides for gruvbox colors
      },
      styles = {
        miscs = {},
      },
      integrations = {
        flash = true,
        gitsigns = true,
        treesitter = true,
        treesitter_context = true,
        native_lsp = {
          enabled = true,
        },
        dap_ui = true,
        dropbar = {
          enabled = true,
          color_mode = true, -- enable color for kind's texts, not just kind's icons
        },
        nvim_surround = true,
        snacks = {
          enabled = true,
          indent_scope_color = "lavender",
        },
      },
    },
    -- init = function()
    --   vim.cmd.colorscheme("catppuccin")
    -- end,
  },
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}
