return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  cmd = "Copilot",
  dependencies = {
    -- {
    --   "copilotlsp-nvim/copilot-lsp",
    --   init = function()
    --     vim.g.copilot_nes_debounce = 1000
    --   end,
    -- },
  },
  opts = {
    panel = {
      auto_refresh = true,
    },
    suggestion = {
      auto_trigger = false,
      keymap = {
        accept = "<A-l>",
      },
    },
    nes = {
      enabled = false,
      auto_trigger = false,
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
