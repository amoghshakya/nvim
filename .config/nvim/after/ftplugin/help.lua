-- open help files in a vertical split on the right
vim.cmd.wincmd("L")
-- close with q
vim.keymap.set("n", "q", "<cmd>bd<CR>", { silent = true, buffer = true })
