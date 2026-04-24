--[[
-- lspconfig setup and configuration
--]]

local M = {}

-- Language Servers to enable
---@type table<string, vim.lsp.Config>
M.servers = {
  -- Special Lua Config, as recommended by neovim help docs
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
        then
          return
        end
      end

      ---@diagnostic disable-next-line
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
          path = { "lua/?.lua", "lua/?/init.lua" },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
            "${3rd}/luv/library",
            "${3rd}/busted/library",
          }),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {},
    },
  },
  ty = {},
  -- tsgo = {},
  vtsls = {},
  tinymist = {
    ---@type lspconfig.settings.tinymist
    settings = {
      projectResolution = "lockDatabase",
      formatterMode = "typstyle",
      exportPdf = "onSave",
      preview = {
        browsing = {
          args = {
            "--data-plane-host=127.0.0.1:0",
            -- "--invert-colors=auto",
            "--open",
          },
        },
      },
    },
  },
  biome = {},
  bashls = {},
  html = {},
  cssls = {},
  astro = {},
  tailwindcss = {},
  emmet_language_server = {},
  -- basedpyright = {},
  rust_analyzer = {},
  clangd = {},
  jsonls = {},
  intelephense = {
    on_attach = function(client, _)
      client.server_capabilities.documentFormattingProvider = true
    end,
    init_options = {
      storagePath = vim.fn.stdpath("cache") .. "/intelephense",
      globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",
      clearCache = false,
    },
    ---@type lspconfig.settings.intelephense
    settings = {
      intelephense = {
        files = {
          maxSize = 5000000,
        },
      },
    },
  },
  texlab = {
    settings = {
      texlab = {
        build = {
          args = {
            "-pdf",
            "-interaction=nonstopmode",
            "-synctex=1",
            "-shell-escape",
            "-emulate-aux-dir",
            "-auxdir=out",
            "%f",
          },
          onSave = false,
          forwardSearchAfter = true,
        },
        forwardSearch = {
          executable = "zathura",
          args = {
            "--synctex-forward",
            "%l:1:%f",
            "%p",
          },
        },
        chktex = {
          onOpenAndSave = true,
        },
      },
    },
  },
  harper_ls = {
    filetypes = { "tex", "latex", "markdown", "typst" },
  },
  gopls = {},
  qmlls = {
    cmd = { "qmlls", "-E" },
  },
  ruby_lsp = {
    -- init_options = {
    --   addonSettings = {
    --     ["Ruby LSP Rails"] = {
    --       enablePendingMigrationsPrompt = false,
    --     },
    --   },
    -- },
  },
}

M.callback = function(event)
  local map = function(keys, func, desc, mode)
    vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  end

  map("grd", require("snacks.picker").lsp_definitions, "[G]oto [D]efinition")
  map("grr", require("snacks.picker").lsp_references, "[G]oto [R]eferences")
  map("gri", require("snacks.picker").lsp_implementations, "[G]oto [I]mplementation")
  map("grt", require("snacks.picker").lsp_type_definitions, "[G]oto [T]ype Definition")
  map("gO", require("snacks.picker").lsp_symbols, "[G]o to Document [O]bjects")
  map("gW", require("snacks.picker").lsp_workspace_symbols, "[G]o to [W]orkspace Symbols")
  map("grn", vim.lsp.buf.rename, "[G]oto [R]e[n]ame")
  map("gra", vim.lsp.buf.code_action, "[G]oto [C]ode [A]ction", { "n", "x" })
  map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
    local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
      end,
    })
  end

  -- emit a progress message for LSP servers that support it
  -- and progress bar for terminals too (Ghostty, Kitty)
  vim.api.nvim_create_autocmd("LspProgress", {
    buffer = event.buf,
    callback = function(ev)
      local value = ev.data.params.value
      vim.api.nvim_echo({ { value.message or "done" } }, false, {
        id = "lsp." .. ev.data.params.token,
        kind = "progress",
        source = "vim.lsp",
        title = value.title,
        status = value.kind ~= "end" and "running" or "success",
        percent = value.percentage,
      })
    end,
  })

  -- Code Lens
  -- enable codelens if LSP supports it
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, event.buf) then
    vim.lsp.codelens.enable()
  end

  -- Inlay Hints toggle
  -- This is handled by snacks so commenting out for now
  -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
  --   map("<leader>th", function()
  --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
  --   end, "[T]oggle Inlay [H]ints")
  -- end
end

---@type vim.diagnostic.Opts
M.diagnostics = {
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = {
    severity = vim.diagnostic.severity.ERROR,
  },
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = "cursor",
        focus = false,
      })
    end,
  },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = true,
  virtual_lines = false,
}

return M
