local M = {}

-- Language Servers to enable
M.servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
      },
    },
  },
  tsgo = {},
  tinymist = {
    settings = {
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
  bashls = {},
  html = {},
  cssls = {},
  astro = {},
  tailwindcss = {},
  emmet_language_server = {},
  basedpyright = {},
  rust_analyzer = {},
  clangd = {},
  jsonls = {},
  intelephense = {
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
    end,
    init_options = {
      storagePath = vim.fn.stdpath("cache") .. "/intelephense",
      globalStoragePath = vim.fn.stdpath("data") .. "/intelephense",
      clearCache = false,
    },
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
  qmlls = {},
}

M.mappings = function(event)
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

  -- Inlay Hints toggle
  -- This is handled by snacks so commenting out for now
  -- if vim.lsp.inlay_hint then
  --   map("<leader>th", function()
  --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
  --   end, "[T]oggle Inlay [H]ints")
  -- end
end

---@type vim.diagnostic.Opts
M.diagnostics = {
  severity_sort = true,
  float = { source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

return M
