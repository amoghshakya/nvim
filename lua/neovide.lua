vim.o.guifont = "Iosevka Nerd Font:h12"
vim.opt.linespace = 4
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_detach_on_quit = "prompt"
vim.g.neovide_fullscreen = false
vim.g.neovide_position_animation_length = 0.1
vim.g.neovide_cursor_trail_size = 0.4
vim.g.neovide_cursor_animate_command_line = false

-- Keybinds

-- Font sizes
vim.keymap.set(
  { "n", "v" },
  "<C-=>",
  ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
  { desc = "Increase font size", silent = true }
)
vim.keymap.set(
  { "n", "v" },
  "<C-->",
  ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
  { desc = "Decrease font size", silent = true }
)
vim.keymap.set(
  { "n", "v" },
  "<C-0>",
  ":lua vim.g.neovide_scale_factor = 1<CR>",
  { desc = "Reset font size", silent = true }
)
