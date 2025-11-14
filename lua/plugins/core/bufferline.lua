return {
  { -- Tabs
    "akinsho/bufferline.nvim",
    version = "*",
    event = { "BufWinEnter" },
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = require("configs.bufferline").keys,
    opts = require("configs.bufferline").opts,
  },
  {
    "tiagovla/scope.nvim",
    event = { "InsertEnter" },
    config = true,
  },
}
