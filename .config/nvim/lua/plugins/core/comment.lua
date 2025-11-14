return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    { -- For context-aware commenting like in tsx or markdown files
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        enable_autocmd = false,
      },
    },
  },
  opts = function()
    -- Pass options below
    return {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }
  end,
}
