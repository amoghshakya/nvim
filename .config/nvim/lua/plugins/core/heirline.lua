return {
  "rebelot/heirline.nvim",
  -- You can optionally lazy-load heirline on UiEnter
  -- to make sure all required plugins and colorschemes are loaded before setup
  event = "UiEnter",
  config = function()
    local utils = require("heirline.utils")
    require("heirline").load_colors(require("configs.statusline").colors())

    vim.api.nvim_create_augroup("Heirline", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        utils.on_colorscheme(require("configs.statusline").colors)
      end,
      group = "Heirline",
    })

    require("heirline").setup({
      statusline = require("configs.statusline").StatusLine,
    })
  end,
}
