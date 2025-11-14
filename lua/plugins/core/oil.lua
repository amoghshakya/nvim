return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  event = "VimEnter", -- want it to show when i run `nvim .`
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
    { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
}
