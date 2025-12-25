return {
  "rebelot/heirline.nvim",
  -- You can optionally lazy-load heirline on UiEnter
  -- to make sure all required plugins and colorschemes are loaded before setup
  event = "UiEnter",
  config = function()
    require("heirline").load_colors(require("configs.statusline").colors())
    require("heirline").setup({
      statusline = require("configs.statusline").StatusLine,
    })

    local utils = require("heirline.utils")
    vim.api.nvim_create_augroup("Heirline", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        utils.on_colorscheme(require("configs.statusline").colors)
      end,
      group = "Heirline",
    })
  end,
}
