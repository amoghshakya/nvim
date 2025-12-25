return {
  "nvim-lualine/lualine.nvim",
  event = { "UiEnter" },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- icons
  opts = require("configs.lualine").opts,
}
