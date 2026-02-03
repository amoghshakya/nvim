return {
  "brianhuster/live-preview.nvim",
  ft = { "markdown", "html", "svg" },
  dependencies = {
    "folke/snacks.nvim",
  },
  config = function()
    require("livepreview.config").set({
      picker = "vim.ui.select",
    })
  end,
}
