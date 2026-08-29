return {
  "dmtrKovalenko/fff",
  build = function()
    require("fff.download").download_or_build_binary()
  end,
  lazy = false,
  keys = {
    {
      "<leader>sf",
      function()
        require("fff").find_files()
      end,
      desc = "[S]earch [F]iles",
    },
    {
      "<leader>sg",
      function()
        require("fff").live_grep()
      end,
      desc = "[S]earch [G]rep",
    },
    {
      "<leader>sw",
      function()
        require("fff").live_grep_under_cursor()
      end,
      mode = { "n", "x" },
      desc = "[S]earch current [W]ord",
    },
    {
      "<leader>sn",
      function()
        require("fff").find_files_in_dir(vim.fn.stdpath("config"))
      end,
      mode = { "n", "x" },
      desc = "[S]earch [N]eovim config",
    },
  },
  opts = {
    frecency = {
      enabled = true,
    },
    debug = {
      enabled = false,
    },
    prompt = "   ",
    layout = {
      prompt_position = "top",
    },
    preview = {
      line_numbers = true,
    },
  },
}
