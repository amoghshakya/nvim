--[[
-- https://github.com/folke/snacks.nvim
-- A collection of QoL plugins for Neovim (Thank you folke!)
--]]

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    ---@type snacks.animate.Config
    animate = {
      easing = "inOutSine",
    },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    -- dashboard = require("configs.snacks").dashboard,
    explorer = require("configs.snacks").explorer,
    indent = {
      enabled = true,
    },
    ---@type snacks.image.Config
    image = {
      enabled = true,
      math = {
        enabled = true,
      },
    },
    input = { enabled = true },
    lazygit = {
      enabled = true,
    },
    notifier = {
      enabled = true,
    },
    picker = require("configs.snacks").picker,
    quickfile = {
      enabled = true,
      exclude = { "latex" },
    },
    rename = { enabled = true },
    scope = { enabled = true },
    statuscolumn = {
      enabled = true,
    },
    terminal = require("configs.snacks").terminal,
    words = { enabled = true },
  },
  keys = require("configs.snacks").keys,
  init = function()
    -- Override icon function to not use mini-icons
    -- Apparently, snacks uses mini-icons even if not enabled
    require("snacks").util.icon = function(name, cat, opts)
      opts = opts or {}
      opts.fallback = opts.fallback or {}
      local try = {
        function()
          if cat == "directory" then
            return opts.fallback.dir or "󰉋 ", "Directory"
          end
          local Icons = require("nvim-web-devicons")
          if cat == "filetype" then
            return Icons.get_icon_by_filetype(name, { default = false })
          elseif cat == "file" then
            local ext = name:match("%.(%w+)$")
            return Icons.get_icon(name, ext, { default = false }) --[[@as string, string]]
          elseif cat == "extension" then
            return Icons.get_icon(nil, name, { default = false }) --[[@as string, string]]
          end
        end,
      }
      for _, fn in ipairs(try) do
        local ret = { pcall(fn) }
        if ret[1] and ret[2] then
          return ret[2], ret[3]
        end
      end
      return opts.fallback.file or "󰈔 "
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tN")
        Snacks.toggle.diagnostics():map("<leader>td")
        Snacks.toggle.line_number():map("<leader>tn")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>tc")
        Snacks.toggle.treesitter():map("<leader>tth")
        Snacks.toggle.inlay_hints():map("<leader>th")
        Snacks.toggle.indent():map("<leader>tg")
      end,
    })
  end,
}
