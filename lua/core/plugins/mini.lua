return {
  "nvim-mini/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
      silent = true,
    })
    require("mini.pairs").setup()
    require("mini.operators").setup()
  end,
}
