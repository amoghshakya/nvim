--[[
--  Buffer Sticks
--  A minimal buffer indicator for Neovim
--]]

return {
  {
    "ahkohd/buffer-sticks.nvim",
    event = "VeryLazy",
    opts = {
      active_modified_char = "──",
      inactive_modified_char = "─",
      alternate_modified_char = "─",
      filter = { buftypes = { "terminal" } },
      highlights = {
        active = { link = "Statement" },
        alternate = { link = "StorageClass" },
        inactive = { link = "Whitespace" },
        active_modified = { link = "Constant" },
        alternate_modified = { link = "Constant" },
        inactive_modified = { link = "Constant" },
        label = { link = "Comment" },
        filter_selected = { link = "Statement" },
        filter_title = { link = "Comment" },
        list_selected = { link = "Statement" },
      },
    },
    config = function(_, opts)
      local sticks = require("buffer-sticks")
      sticks.setup(opts)
      sticks.show()
    end,
    keys = {
      {
        "<leader>j",
        function()
          BufferSticks.jump()
        end,
        desc = "[J]ump to buffer",
        silent = true,
      },
    },
  },
  {
    "tiagovla/scope.nvim",
    event = { "BufWinEnter" },
    config = true,
  },
}
