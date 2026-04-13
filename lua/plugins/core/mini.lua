return {
  "nvim-mini/mini.nvim",
  version = false,
  event = { "VeryLazy" },
  config = function()
    require("mini.ai").setup({
      n_lines = 500,
      silent = true,
    })
    require("mini.operators").setup()
    require("mini.comment").setup({
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    })
    -- require("mini.sessions").setup({
    --   silent = true,
    -- })
  end,
}
