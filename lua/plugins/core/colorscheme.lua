return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000, -- Ensure it loads first
    ---@type CatppuccinOptions
    opts = {
      auto_integrations = true,
      styles = {
        keywords = { "italic" },
        -- miscs = {},
      },
      lsp_styles = {
        underlines = {
          errors = { "undercurl" },
        },
      },
      custom_highlights = function(colors)
        return {
          NormalFloat = {
            bg = colors.base,
          },
          FloatBorder = {
            bg = colors.base,
          },
          Keyword = {
            fg = colors.peach,
          },
          -- @method also links to this so you'd be updating both of them?
          -- Function = {
          --   fg = colors.yellow,
          -- },
          Type = {
            fg = colors.sapphire,
          },
          -- make constants stand out?
          Constant = {
            fg = colors.flamingo,
          },
          BlinkCmpMenuBorder = {
            bg = colors.base,
          },
          BlinkCmpMenu = {
            bg = colors.base,
          },
          BlinkCmpMenuSelection = {
            bg = colors.yellow,
            fg = colors.base,
          },
          BlinkCmpDocBorder = {
            bg = colors.base,
          },
          BlinkCmpDoc = {
            bg = colors.base,
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
      local path = vim.fn.stdpath("config") .. "/lua/catppuccin/palettes/"
      local files = vim.fn.globpath(path, "*", false, true)
      local flavours = {
        latte = 1,
        frappe = 2,
        macchiato = 3,
        mocha = 4,
      }

      for i, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        flavours[name] = 4 + i
      end

      local catppuccin = require("catppuccin")
      catppuccin.flavours = flavours
      catppuccin.setup(opts)
      vim.cmd.colorscheme("catppuccin-ayu")
    end,
  },
}
