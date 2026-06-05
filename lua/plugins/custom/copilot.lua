return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  opts = {
    panel = {
      auto_refresh = true,
    },
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<A-l>",
      },
    },
    nes = {
      enabled = false,
      auto_trigger = true,
      keymap = {
        accept_and_goto = "<C-y>",
        next = "<A-n>",
        accept = false,
        dismiss = "<Esc>",
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuOpen",
      callback = function()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "BlinkCmpMenuClose",
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}
