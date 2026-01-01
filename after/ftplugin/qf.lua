-- don't list quickfix buffers in buffer lists
vim.opt_local.buflisted = false
-- close quickfix window with `q` (convenience)
vim.keymap.set("n", "q", "<cmd>bd<CR>", { silent = true, buffer = true })
