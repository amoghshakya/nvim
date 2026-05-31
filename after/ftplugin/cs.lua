vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("RoslynDiagnosticConfig", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- ensure we are only touching the Roslyn configuration
    if client and client.name == "roslyn" then
      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.INFO },
        },
      })
    end
  end,
})
