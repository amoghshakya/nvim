-- debugging plugins
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- Installs the debug adapters for you
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Python debugging support
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
    },
  },
  keys = require("core.configs.debug").keys,
  config = require("core.configs.debug").config,
}
