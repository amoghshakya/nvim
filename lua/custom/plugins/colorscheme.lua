return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Ensure it loads first
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha or auto
      default_integrations = true,
      auto_integrations = true,
      styles = {
        misc = { "italic" },
      },
      color_overrides = {
        mocha = require("custom.configs.colorscheme").gruvbox_mocha,
      },
      integrations = {
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
          picker_style = "nvchad",
        },
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
