local map = vim.keymap.set

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

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
map("n", "<2-LeftMouse>", "<C-]>", { noremap = true, silent = true })

-- Buffers
map("n", "<Tab>", "<Cmd>bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-Tab>", "<Cmd>bNext<CR>", { desc = "Next buffer", silent = true })
map("n", "<leader>nn", "<Cmd>enew<CR>", { desc = "[N]ew empty buffer", silent = true })
map("n", "<leader>x", function()
  -- Closes the buffer without affecting the split layout
  require("snacks.bufdelete").delete()

  -- If the buffer is the last one, close the split as well.
  -- This feels more natural to me than closing the split first.
  vim.schedule(function()
    local bufnr = vim.api.nvim_get_current_buf()
    -- Count listed buffers
    local listed = vim.tbl_filter(function(b)
      return vim.bo[b].buflisted
    end, vim.api.nvim_list_bufs())

    if #listed <= 1 then
      if #vim.fn.win_findbuf(bufnr) > 1 then
        -- If more than one window, safe to close
        vim.cmd("close")
      end
    end
  end)
end, { desc = "Close buffer", silent = true })

-- Tabs
map("n", "<leader>ct", "<Cmd>tabclose<CR>", { desc = "[C]lose [T]ab", silent = true })
map("n", "<leader>nt", "<Cmd>tabnew<CR>", { desc = "[N]ew [T]ab", silent = true })
