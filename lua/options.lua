local o = vim.o
local opt = vim.opt
local g = vim.g

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Set border style of floating windows.
o.winborder = "single"

-- Convert tabs to spaces
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.autoindent = true

-- Make line numbers default
o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
o.mouse = "a"
o.mousemoveevent = true

-- Don't show the mode, since it's already in the status line
o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  o.clipboard = "unnamedplus"
end)

-- Enable break indent
o.breakindent = true

-- Save undo history
o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
o.ignorecase = true
o.smartcase = true

-- Keep signcolumn on by default
o.signcolumn = "yes"

-- Decrease update time
o.updatetime = 250

-- Decrease mapped sequence wait time
o.timeoutlen = 300

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- global statusline
opt.laststatus = 3

-- Preview substitutions live, as you type!
o.inccommand = "split"

-- Show which line your cursor is on
o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
o.scrolloff = 10

-- Code folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
o.confirm = true

-- Autoread files when changed outside of Neovim
o.autoread = true

opt.fillchars:append({ eob = " ", diff = "╱" })

o.termguicolors = true
o.cursorlineopt = "both"

opt.path:append("**")
opt.isfname:append(":")

-- Disable nvim intro
opt.shortmess:append("I")

-- Experimental
-- With UI2, there is not more annoying “Press Enter” prompt after you run a command.
-- use `g<` to check the full messages
-- require("vim._core.ui2").enable({
--   enable = true,
--   msg = { -- Options related to the message module.
--     ---@type 'cmd'|'msg' Default message target, either in the
--     ---cmdline or in a separate ephemeral message window.
--     ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
--     ---or table mapping |ui-messages| kinds and triggers to a target.
--     targets = "cmd",
--     cmd = { -- Options related to messages in the cmdline window.
--       height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
--     },
--     dialog = { -- Options related to dialog window.
--       height = 0.5, -- Maximum height.
--     },
--     msg = { -- Options related to msg window.
--       height = 0.5, -- Maximum height.
--       timeout = 4000, -- Time a message is visible in the message window.
--     },
--     pager = { -- Options related to message window.
--       height = 0.5, -- Maximum height.
--     },
--   },
-- })

-- Neovide settings
if g.neovide then
  require("neovide")
end
