-- LSP Plugins

return {
  { -- Core LSP setup
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        lazy = true,
        cmd = "Mason",
        opts = {
          registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
          },
          path = "skip",
          ui = {
            icons = {
              package_pending = " ",
              package_installed = " ",
              package_uninstalled = " ",
            },
          },
        },
      },
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      vim.diagnostic.config(require("configs.lsp").diagnostics)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = require("configs.lsp").callback,
      })

      local servers = require("configs.lsp").servers or {}
      vim.schedule(function()
        -- Only auto install servers that are not already installed, and only if they are in the mason registry
        local mason_mapping = require("mason-lspconfig.mappings").get_all().lspconfig_to_package
        local ensure_installed = {}

        for server, _ in pairs(servers) do
          local pkg = mason_mapping[server]
          if type(pkg) ~= "string" or vim.fn.executable(pkg) == 0 then
            table.insert(ensure_installed, server)
          end
        end

        if #ensure_installed > 0 then
          require("mason-lspconfig").setup({
            automatic_enable = ensure_installed,
            ensure_installed = ensure_installed,
          })
        end
      end)

      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    end,
  },
  { -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "nvim-lspconfig", words = { "lspconfig" } },
      },
    },
  },
  {
    "yioneko/nvim-vtsls",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = nil,
    config = false,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
}
