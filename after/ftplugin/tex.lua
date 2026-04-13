vim.o.conceallevel = 2

if not vim.g.vscode then
  -- vim.opt_local.spell = true
  vim.opt_local.spelllang = "en_us"
  require("virt-column").update({ virtcolumn = "80" })
end
