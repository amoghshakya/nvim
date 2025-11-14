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
        mocha = require("configs.colorscheme").rosepine.dark,
      },
      custom_highlights = function(colors)
        return {
          lualine_c_normal = {
            bg = colors.base,
            fg = colors.text,
          },
        }
      end,
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
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
