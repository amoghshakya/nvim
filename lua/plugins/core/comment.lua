return {
  { -- For context-aware commenting like in tsx or markdown files
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable_autocmd = false,
    },
  },
}
