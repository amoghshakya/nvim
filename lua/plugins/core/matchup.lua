return { -- % Matching
  "andymass/vim-matchup",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.g.matchup_matchparen_deferred = 1
    vim.g.matchup_matchparen_offscreen = {}
  end,
}
