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
    },
    config = function()
      vim.diagnostic.config(require("configs.lsp").diagnostics)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = require("configs.lsp").callback,
      })

      local servers = require("configs.lsp").servers or {}
      vim.schedule(function()
        local registry = require("mason-registry")
        -- Build lspconfig name -> mason package name map from registry
        local lspconfig_to_mason = {}
        for _, pkg_spec in ipairs(registry.get_all_package_specs()) do
          local lspconfig_name = vim.tbl_get(pkg_spec, "neovim", "lspconfig")
          if lspconfig_name then
            lspconfig_to_mason[lspconfig_name] = pkg_spec.name
          end
        end

        for server, _ in pairs(servers) do
          local mason_pkg = lspconfig_to_mason[server]
          if mason_pkg then
            local ok, pkg = pcall(registry.get_package, mason_pkg)
            if ok and not pkg:is_installed() then
              pkg:install()
            end
          end
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
