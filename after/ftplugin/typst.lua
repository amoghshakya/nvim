vim.api.nvim_create_user_command("OpenPdf", function()
  local filepath = vim.api.nvim_buf_get_name(0)
  if filepath:match("%.typ$") then
    local pdf_path = filepath:gsub("%.typ$", ".pdf")
    -- make sioyek open the pdf
    vim.system({ "sioyek", pdf_path })
    -- macOS but make sure the default pdf viewer supports live reload
    -- vim.system({ "open", pdf_path })
  end
end, {})
