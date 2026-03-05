--[[
-- blink.cmp
-- A completion engine for Neovim that provides a fast and flexible way to complete code.
--]]

return {
  "saghen/blink.cmp",
  event = { "InsertEnter" },
  version = "*",
  dependencies = {
    { -- optional: provides snippets for the snippet source
      "L3MON4D3/LuaSnip",
      event = { "InsertEnter" },
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip").filetype_extend("blade", { "html" })
          end,
        },
      },
    },
    "fang2hou/blink-copilot",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = {
      preset = "luasnip",
      -- score_offset = 20,
    },

    keymap = {
      preset = "enter",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          end
          return nil
        end,
        "select_next",
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_backward()
          end
          return nil
        end,
        "select_prev",
        "fallback",
      },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
      kind_icons = {
        Method = "",
        Keyword = "󰌋",
        Constructor = "󰆧",
        Class = "",
        Interface = "",
        Struct = "",
        Variable = "󰀫",
        Snippet = "",
      },
    },

    completion = {
      accept = {
        create_undo_point = true,
        auto_brackets = {
          enabled = true,
          kind_resolution = {
            enabled = true,
            blocked_filetypes = {
              "typescriptreact",
              "javascriptreact",
              "vue",
              "astro",
            },
          },
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = {
              "java",
            },
          },
        },
      },
      menu = {
        -- overriding neovim's border opts here
        border = "padded",
        draw = {
          padding = { 0, 1 },
          components = {
            kind_icon = {
              text = function(ctx)
                return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
              end,
            },
          },
          columns = {
            { "kind_icon" },
            { "label", "label_description", "kind", gap = 1 },
          },
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 300,
      },
      trigger = {
        show_on_keyword = true,
        show_on_insert = false,
        show_on_trigger_character = false,
        show_on_insert_on_trigger_character = false,
      },
      list = {
        selection = {
          auto_insert = false,
        },
        cycle = {
          from_bottom = true,
          from_top = true,
        },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "copilot" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        lazydev = {
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 50,
          async = true,
        },
      },
    },

    signature = {
      enabled = true,
    },

    fuzzy = {
      implementation = "prefer_rust",
      frecency = {
        enabled = true,
      },
    },

    -- blink autocomplete for commandline
    cmdline = {
      enabled = false,
    },
  },
  opts_extend = { "sources.default" },
}
