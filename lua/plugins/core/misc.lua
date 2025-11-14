--[[
-- Some useful plugins that don't fit into any specific category
--]]

return {
  { -- Detect tabstop and shiftwidth automatically
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
  { -- Autoformat
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format()
        end,
        mode = "",
        desc = "[F]or[m]at buffer",
      },
    },
    opts = require("configs.conform"),
  },
  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
}
