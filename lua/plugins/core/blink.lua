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
      nerd_font_variant = "normal",
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
        draw = {
          padding = { 1, 1 },
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require("lspkind").symbol_map[ctx.kind] or ""
                end

                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
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
        lsp = {
          score_offset = 100,
        },
        lazydev = {
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          -- this is so annoying, copilot always suggests crap horseshit, i'd
          -- remove it but sometimes it comes up with a good suggestion
          -- NOTE: future self: consider getting rid of copilot and ai slop
          score_offset = 1,
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
