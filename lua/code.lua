local map = vim.keymap.set

-- view open buffers
map("n", "<leader><leader>", function()
  vim.fn.VSCodeNotify("workbench.action.showAllEditors")
end, {
  desc = "View Open Buffers",
  silent = true,
  remap = false,
})

-- searching files
map("n", "<leader>sf", function()
  vim.fn.VSCodeNotify("workbench.action.quickOpen")
end, {
  desc = "[S]earch [F]iles",
  silent = true,
  remap = false,
})

-- search in buffer
map("n", "<leader>/", function()
  vim.fn.VSCodeNotify("actions.find")
end, {
  desc = "[S]earch in [B]uffer",
  silent = true,
  remap = false,
})

-- search diagnostics
map("n", "<leader>sd", function()
  vim.fn.VSCodeNotify("workbench.action.problems.focus")
end, {
  desc = "[S]earch [D]iagnostics",
  silent = true,
  remap = false,
})

-- live grep
map("n", "<leader>sg", function()
  vim.fn.VSCodeNotify("workbench.action.findInFiles")
end, {
  desc = "[S]earch by [G]rep",
  silent = true,
  remap = false,
})

-- recent files
map("n", "<leader>s.", function()
  vim.fn.VSCodeNotify("workbench.action.openRecent")
end, {
  desc = "[S]earch [.] recent files",
  silent = true,
  remap = false,
})

-- searching colorschemes
map("n", "<leader>sc", function()
  vim.fn.VSCodeNotify("workbench.action.selectTheme")
end, {
  desc = "[S]earch [C]olorschemes",
  silent = true,
  remap = false,
})

-- setting file type
map("n", "<leader>ft", function()
  vim.fn.VSCodeNotify("workbench.action.editor.changeLanguageMode")
end, {
  desc = "Change [F]ile [T]ype",
  silent = true,
  remap = false,
})

-- <C-n> to toggle file explorer
map("n", "<C-n>", function()
  vim.fn.VSCodeNotify("workbench.action.toggleSidebarVisibility")
  vim.fn.VSCodeNotify("workbench.view.explorer")
end, {
  desc = "Focus on Explorer",
  silent = true,
  remap = true,
})

-- Focus file explorer
map("n", "<leader>e", function()
  vim.fn.VSCodeNotify("workbench.view.explorer")
end, {
  desc = "Focus on Explorer",
  silent = true,
  remap = false,
})

-- <leader>nn for new empty buffer
map("n", "<leader>nn", function()
  vim.fn.VSCodeNotify("workbench.action.files.newUntitledFile")
end, {
  desc = "Create [N]ew File",
  silent = true,
  remap = false,
})

-- close buffer
map("n", "<leader>x", function()
  vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
end, { desc = "Close buffer", silent = true })

-- accept inline suggestion
map("i", "<A-l>", function()
  vim.fn.VSCodeNotify("editor.action.inlineSuggest.commit")
end, { desc = "Accept inline suggestion", silent = true })

--[[ LSP STUFF ]]
-- renaming variables
map("n", "grn", function()
  vim.fn.VSCodeNotify("editor.action.rename")
end, {
  desc = "[G]o to [R]e[n]ame",
  silent = true,
  remap = false,
})

-- go to definition
map("n", "grd", function()
  vim.fn.VSCodeNotify("editor.action.revealDefinition")
end, {
  desc = "[G]o to [D]efinition",
  silent = true,
})

-- go to declaration
map("n", "grD", function()
  vim.fn.VSCodeNotify("editor.action.revealDeclaration")
end, {
  desc = "[G]o to [D]eclaration",
  silent = true,
})

-- go to implementation
-- Note: VSCode does not have a default keybinding for "Go to Implementation"
-- You might want to set it up in your VSCode keybindings settings
map("n", "gri", function()
  vim.fn.VSCodeNotify("editor.action.goToImplementation")
end, {
  desc = "[G]o to [I]mplementation",
  silent = true,
})

-- go to references
map("n", "grr", function()
  vim.fn.VSCodeNotify("editor.action.goToReferences")
end, {
  desc = "[G]o to [R]eferences",
  silent = true,
})

-- go to type definition
map("n", "grt", function()
  vim.fn.VSCodeNotify("editor.action.goToTypeDefinition")
end, {
  desc = "[G]o to [T]ype Definition",
  silent = true,
})

-- format code
map("n", "<leader>fm", function()
  vim.fn.VSCodeNotify("editor.action.formatDocument")
end, {
  desc = "[F]ormat code",
  silent = true,
  remap = false,
})

-- autocompletes
map("i", "<Tab>", function()
  vim.fn.VSCodeNotify("selectNextSuggestion")
end, { expr = true, silent = true, desc = "Trigger completion", remap = true })
map("i", "<S-Tab>", function()
  vim.fn.VSCodeNotify("selectPrevSuggestion")
end, { expr = true, silent = true, desc = "Trigger completion", remap = true })
