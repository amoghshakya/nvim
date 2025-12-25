-- LSP Plugins

return {
  { -- Core LSP setup
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        cmd = "Mason",
        opts = {
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
      {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {
          progress = {
            ignore = {
              "ltex_plus",
            },
          },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = require("configs.lsp").mappings,
      })
      vim.diagnostic.config(require("configs.lsp").diagnostics)

      local servers = require("configs.lsp").servers or {}
      local ensure_installed = {}

      -- Sometimes Mason will install the LSP servers automatically, even the
      -- ones that are already present on the system. I could disable automatic
      -- installation, but I prefer to keep it enabled.
      local mason_mapping = require("mason-lspconfig.mappings").get_all().lspconfig_to_package

      -- Instead only ensure installation of binaries that are not already in
      -- the system
      for server, _ in pairs(servers) do
        local pkg = mason_mapping[server]
        if vim.fn.executable(pkg) == 0 then
          table.insert(ensure_installed, server)
        end
      end

      require("mason-lspconfig").setup({
        automatic_enable = ensure_installed,
        ensure_installed = ensure_installed,
      })

      -- Overriding default LSP config with the ones specified in `servers`
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
      },
    },
  },
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   ft = {
  --     "typescript",
  --     "typescriptreact",
  --     "typescript.tsx",
  --     "javascript",
  --     "javascriptreact",
  --     "javascript.jsx",
  --     "astro",
  --   },
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  -- },
  {
    "Bekaboo/dropbar.nvim",
    config = function()
      local dropbar_api = require("dropbar.api")
      vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
      vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
      vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    end,
  },
}
