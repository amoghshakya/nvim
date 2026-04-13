return { -- % Matching
  "andymass/vim-matchup",
  event = { "BufReadPost", "BufNewFile" },
  ---@type matchup.Config
  opts = {
    treesitter = {
      enabled = true,
      stopline = 500,
    },
    matchparen = {
      deferred = 1,
      offscreen = {},
    },
  },
}
