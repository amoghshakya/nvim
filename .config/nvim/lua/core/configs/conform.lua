local opts = {
  default_format_opts = {
    -- These options will be passed to conform.format()
    async = true,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "prettierd", stop_after_first = true },
    javascriptreact = { "prettier", "prettierd", stop_after_first = true },
    typescript = { "prettier", "prettierd", stop_after_first = true },
    typescriptreact = { "prettier", "prettierd", stop_after_first = true },
    astro = { "prettier", "prettierd", stop_after_first = true },
    json = { "prettier" },
    jsonc = { "prettier" },
    python = { "ruff_format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    rust = { "rustfmt" },
    tex = { "latexindent" },
    plaintex = { "latexindent" },
    bib = { "bibtex-tidy" },
    -- typst = { "prettypst" },
    markdown = { "markdownlint", "prettier" },
    htmldjango = { "djlint" },
    sql = { "sql_formatter" },
    blade = { "blade-formatter" },
  },
  formatters = {
    latexindent = {
      command = "latexindent",
      args = {
        "-y=defaultIndent: '  '",
        "-m",
        "-g=/dev/null",
      },
    },
    ["blade-formatter"] = {
      command = "blade-formatter",
      args = { "--stdin", "--sort-tailwindcss-classes" },
      stdin = true,
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
}

return opts
