---@type conform.setupOpts
local opts = {
  default_format_opts = {
    -- These options will be passed to conform.format()
    async = true,
    quiet = false,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    go = { "gofmt" },
    lua = { "stylua" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    astro = { "prettierd", "prettier", stop_after_first = true },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    python = { "ruff_format" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    rust = { "rustfmt" },
    tex = {
      "tex-fmt",
      "latexindent",
      stop_after_first = true,
    },
    plaintex = { "latexindent" },
    bib = { "bibtex-tidy" },
    typst = { "typstyle" },
    markdown = { "markdownlint", "prettier" },
    htmldjango = { "djlint" },
    sql = { "sql_formatter" },
    blade = { "blade-formatter" },
    qml = { "qmlformat" },
    toml = { "taplo" },
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
    typstyle = {
      args = { "--wrap-text" },
    },
  },
  format_on_save = {
    timeout_ms = 500,
  },
}

return opts
