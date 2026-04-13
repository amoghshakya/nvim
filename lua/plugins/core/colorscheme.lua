return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- Ensure it loads first
    ---@type CatppuccinOptions
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha or auto
      default_integrations = true,
      auto_integrations = true,
      color_overrides = {
        mocha = require("configs.colorscheme").ayu.dark,
      },
      styles = {
        keywords = { "italic" },
        -- miscs = {},
      },
      custom_highlights = function(colors)
        return {
          SnacksPickerInputTitle = {
            fg = colors.base,
            bg = colors.red,
          },
          SnacksPickerPreviewTitle = {
            fg = colors.base,
            bg = colors.green,
          },
          SnacksPickerTitle = {
            fg = colors.base,
            bg = colors.blue,
            style = { "bold" },
          },
          SnacksPickerBoxTitle = {
            fg = colors.mantle,
            bg = colors.blue,
            style = { "bold" },
          },
          Keyword = {
            fg = colors.peach,
          },
          -- @method also links to this so you'd be updating both of them?
          Function = {
            fg = colors.yellow,
          },
          Type = {
            fg = colors.sapphire,
          },
          -- make constants stand out?
          Constant = {
            fg = colors.flamingo,
          },
        }
      end,
      integrations = {
        flash = true,
        gitsigns = true,
        treesitter = true,
        treesitter_context = true,
        mason = true,
        blink_cmp = {
          style = "bordered",
        },
        dap = true,
        dap_ui = true,
        dropbar = {
          enabled = true,
          color_mode = true, -- enable color for kind's texts, not just kind's icons
        },
        nvim_surround = true,
        neogit = true,
        snacks = {
          enabled = true,
          indent_scope_color = "lavender",
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-nvim")
    end,
  },
}
