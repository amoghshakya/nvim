local map = vim.keymap.set

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Rounded borders for LSP Hovers
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({
    border = "rounded",
    focusable = false,
  })
end, {
  desc = "Show hover information",
  remap = true,
  silent = true,
})

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Save with Ctrl S (CRAZY I KNOW)
map("n", "<C-s>", "<cmd>write<CR>", { desc = "Save current file" })
map("i", "<C-s>", "<cmd>write<CR>", { desc = "Save current file" })

-- Comment with <C-/>
--  See `:help commentstring` for more information
map("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "Toggle comment", remap = true })

-- Weird stuff
map("n", "<2-LeftMouse>", "gf", { noremap = true, silent = true })

-- Buffers
map("n", "<leader>n", "<Cmd>enew<CR>", { desc = "[N]ew empty buffer", silent = true })
map("n", "<leader>x", "<Cmd>bdelete<CR>", { desc = "Close buffer", silent = true })

-- Toggle numberlines
map("n", "<leader>tn", function()
  if vim.wo.number then
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end, { desc = "[T]oggle line [n]umbers", silent = true })
