local M = {}

local utils = require("heirline.utils")

local function multi_tab_condition()
  -- only show if there's 2 or more tabpages
  return #vim.api.nvim_list_tabpages() >= 2
end

local Tabpage = {
  provider = function(self)
    return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
  end,
  hl = function(self)
    if not self.is_active then
      return "TabLine"
    else
      return "TabLineSel"
    end
  end,
}

local TabpageClose = {
  provider = "%999X  %X",
  hl = {
    fg = "bright_fg",
    bg = "dark_red",
  },
}

local TabPages = {
  condition = multi_tab_condition,
  { provider = "%=" },
  hl = {
    bg = "bright_bg",
    fg = "bright_fg",
  },
  utils.make_tablist(Tabpage),
  TabpageClose,
}

local TabLineOffset = {
  condition = function(self)
    local win = vim.api.nvim_tabpage_list_wins(0)[1]
    local bufnr = vim.api.nvim_win_get_buf(win)
    self.winid = win

    if vim.bo[bufnr].filetype == "snacks_picker_list" then
      self.title = "Snacks Picker"
      return true
      -- elseif vim.bo[bufnr].filetype == "TagBar" then
      --     ...
    end
  end,

  provider = function(self)
    local title = self.title
    local width = vim.api.nvim_win_get_width(self.winid)
    local pad = math.ceil((width - #title) / 2)
    return string.rep(" ", pad) .. title .. string.rep(" ", pad)
  end,

  hl = function(self)
    if vim.api.nvim_get_current_win() == self.winid then
      return "TablineSel"
    else
      return "Tabline"
    end
  end,
}

M.TabLine = {
  condition = multi_tab_condition,
  TabLineOffset,
  TabPages,
}

-- Yep, with heirline we're driving manual!
-- vim.o.showtabline = 2 -- 2 means always show tabline
vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

return M
