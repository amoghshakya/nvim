---@type conform.setupOpts
local opts = {
  default_format_opts = {
    -- These options will be passed to conform.format()
    async = true,
    quiet = false,
    lsp_format = "never",
  },
  formatters_by_ft = {
    go = { "gofmt" },
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
