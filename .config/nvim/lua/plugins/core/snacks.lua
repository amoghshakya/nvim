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
