local autocmd = vim.api.nvim_create_autocmd

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Close windows with `q`
autocmd("FileType", {
  pattern = { "qf", "help" },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bd<CR>", { silent = true, buffer = true })
  end,
})

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], {
      buffer = true,
      desc = "Exit terminal mode",
    })
  end,
})

-- Kitty padding
autocmd("VimEnter", {
  desc = "Remove kitty padding on startup",
  command = ":silent !kitty @ set-spacing padding=0 margin=0",
})

autocmd("VimLeavePre", {
  desc = "Remove kitty padding on startup",
  command = ":silent !kitty @ set-spacing padding=4 margin=0",
})
