--[[
-- Statusline configuration (for heirline)
--
-- A lot of work but greater control!
--]]

local M = {}

local excluded_filetypes = {
  -- "TelescopePrompt",
  "snacks_dashboard",
  "snacks_picker_input",
  "snacks_picker_list",
  "snacks_layout_box",
  "fugitive",
  "oil",
  "snacks_terminal",
}

-- put it in a variable to easily change icons later
local diff_icons = {
  added = " ",
  removed = " ",
  changed = " ",
}

local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local colors = {
  bright_bg = utils.get_highlight("Normal").bg,
  dark_bg = utils.get_highlight("StatusLine").bg,
  bright_fg = utils.get_highlight("Normal").fg,
  dark_fg = utils.get_highlight("StatusLineNC").fg,
  red = utils.get_highlight("DiagnosticError").fg,
  dark_red = utils.get_highlight("DiffDelete").bg,
  green = utils.get_highlight("String").fg,
  blue = utils.get_highlight("Function").fg,
  gray = utils.get_highlight("NonText").fg,
  orange = utils.get_highlight("Constant").fg,
  purple = utils.get_highlight("Statement").fg,
  cyan = utils.get_highlight("Special").fg,
  diag_warn = utils.get_highlight("DiagnosticWarn").fg,
  diag_error = utils.get_highlight("DiagnosticError").fg,
  diag_hint = utils.get_highlight("DiagnosticHint").fg,
  diag_info = utils.get_highlight("DiagnosticInfo").fg,
  git_del = utils.get_highlight("diffRemoved").fg,
  git_add = utils.get_highlight("diffAdded").fg,
  git_change = utils.get_highlight("diffChanged").fg,
}

local function is_git_repo()
  local git_dir = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
  return git_dir ~= ""
end

local function has_git_changes()
  local status_dict = vim.b.gitsigns_status_dict
  return status_dict
    and ((status_dict.added or 0) ~= 0 or (status_dict.removed or 0) ~= 0 or (status_dict.changed or 0) ~= 0)
end

M.colors = function()
  return colors
end

local Space = {
  provider = " ",
}

local ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = {
      n = "NORMAL",
      -- Operator-pending (When you press d, y, c and Vim waits for a motion)
      no = "O-PEND",
      nov = "O-PEND",
      noV = "O-PEND",
      ["no\22"] = "O-PEND",
      i = "INSERT",
      ic = "I-COMP",
      ix = "I-X",
      niI = "I-NORM",
      niR = "R-NORM",
      niV = "V-NORM",
      -- Visual modes
      v = "VISUAL",
      V = "V-LINE",
      ["\22"] = "V-BLOCK",
      vs = "V-SELECT",
      Vs = "V-SELECT",
      ["\22s"] = "V-SELECT",
      R = "REPLACE",
      Rc = "REPLACE",
      Rx = "REPLACE",
      Rv = "V-REPLACE",
      Rvc = "V-REPLACE",
      Rvx = "V-REPLACE",
      c = "COMMAND",
      cv = "EX",
      ["!"] = "SHELL",
      t = "TERMINAL",
      nt = "TERMINAL",
      r = "PROMPT",
      rm = "MORE",
      ["r?"] = "CONFIRM",
      s = "SELECT",
      S = "S-LINE",
      ["\19"] = "S-BLOCK",
    },
    mode_colors = {
      n = colors.blue,
      i = colors.green,
      v = colors.purple,
      V = colors.cyan,
      ["\22"] = colors.teal, -- ts also visual
      c = colors.orange,
      s = colors.purple,
      S = colors.purple,
      ["\19"] = colors.purple,
      R = colors.red,
      r = colors.orange,
      ["!"] = colors.red,
      t = colors.green,
    },
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    -- local icon = ""
    -- return " " .. icon .. " %2(" .. self.mode_names[self.mode] .. "%) "
    return " %2(" .. self.mode_names[self.mode] .. "%) "
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return {
      fg = colors.bright_bg,
      bg = self.mode_colors[mode],
      bold = true,
    }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- Also allows the statusline to be re-evaluated when entering operator-pending mode
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function()
      vim.cmd("redrawstatus")
    end),
  },
}

local Ruler = {
  provider = "%7(%l:%c%) ",
}

local Percentage = {
  provider = " %P ",
}

local Diagnostics = {
  condition = conditions.has_diagnostics,

  init = function(self)
    -- Safely fetch icons from the config
    local config = vim.diagnostic.config() or {} -- lua ls might complain otherwise
    -- Defensive check: if signs isn't a table with text
    local signs = (type(config.signs) == "table" and config.signs.text)
      or require("configs.lsp").diagnostics.signs.text -- this definitely exists
      or {} -- add this so lsp doesn't go crazy on us

    -- Store icons in 'self' so providers can see them
    self.error_icon = signs[vim.diagnostic.severity.ERROR]
    self.warn_icon = signs[vim.diagnostic.severity.WARN]
    self.info_icon = signs[vim.diagnostic.severity.INFO]
    self.hint_icon = signs[vim.diagnostic.severity.HINT]

    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = {
    "BufEnter",
    "DiagnosticChanged",
  },

  -- Format
  {
    provider = " ",
  },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors)
    end,
    hl = { fg = colors.diag_error },
  },
  {
    provider = " ",
    condition = function(self)
      return self.errors > 0 and (self.warnings > 0 or self.info > 0 or self.hints > 0)
    end,
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings)
    end,
    hl = { fg = colors.diag_warn },
  },
  {
    provider = " ",
    condition = function(self)
      return self.warnings > 0 and (self.info > 0 or self.hints > 0)
    end,
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info)
    end,
    hl = { fg = colors.diag_info },
  },
  {
    provider = " ",
    condition = function(self)
      return self.info > 0 and self.hints > 0
    end,
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = colors.diag_hint },
  },
  {
    provider = " ",
  },
}

local GitDiff = {
  condition = conditions.is_git_repo,

  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict
      and (
        (self.status_dict.added or 0) ~= 0
        or (self.status_dict.removed or 0) ~= 0
        or (self.status_dict.changed or 0) ~= 0
      )
  end,

  {
    condition = function(self)
      return self.has_changes
    end,
    Space,
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and (diff_icons.added .. count)
      end,
      hl = { fg = colors.git_add },
    },
    {
      provider = " ",
      condition = function(self)
        return (self.status_dict.added or 0) > 0
          and ((self.status_dict.removed or 0) > 0 or (self.status_dict.changed or 0) > 0)
      end,
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and (diff_icons.removed .. count)
      end,
      hl = { fg = colors.git_del },
    },
    {
      provider = " ",
      condition = function(self)
        return (self.status_dict.removed or 0) > 0 and (self.status_dict.changed or 0) > 0
      end,
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and (diff_icons.changed .. count)
      end,
      hl = { fg = colors.git_change },
    },
    Space,
  },
}

local GitBranch = {
  condition = is_git_repo,

  hl = {
    bg = colors.blue,
    fg = colors.bright_bg,
  },

  init = function(self)
    local status_dict = vim.b.gitsigns_status_dict
    if status_dict then
      self.status_dict = vim.b.gitsigns_status_dict
    else
      -- because heirline relies on gitsigns for git info
      -- but gitsigns might not be loaded yet, we fallback to git cli
      local head = vim.fn.systemlist("git branch --show-current 2>/dev/null")[1]

      if not head then
        head = ""
      end

      self.status_dict = { head = head }
    end
  end,

  { -- git branch name
    provider = function(self)
      return "  " .. self.status_dict.head .. " "
    end,
    hl = { bold = true },
  },
}

local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  condition = function(_)
    return not vim.tbl_contains(excluded_filetypes, vim.bo.filetype) and vim.bo.filetype ~= "help"
  end,
}

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, {
      default = true,
    })
  end,
  provider = function(self)
    return self.icon and (" " .. self.icon)
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    if filename == "" then
      return " [No Name] "
    end
    -- Space on right to separate from flags or next component
    return " " .. filename .. " "
  end,
  hl = { fg = colors.bright_fg },
}

local FileFlags = {
  {
    condition = function()
      return vim.bo.modified
    end,
    provider = " ", -- A simple dot for modified
    hl = { fg = colors.green },
  },
  {
    condition = function()
      return not vim.bo.modifiable or vim.bo.readonly
    end,
    provider = " ",
    hl = { fg = colors.red },
  },
}

FileNameBlock = utils.insert(FileNameBlock, FileIcon, FileName, FileFlags, { provider = "%<" })

local HelpFileName = {
  condition = function()
    return vim.bo.filetype == "help"
  end,
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return " 󰞋 " .. vim.fn.fnamemodify(filename, ":t") .. " "
  end,
  hl = {
    bold = true,
  },
}

local TerminalName = {
  condition = function()
    return vim.bo.filetype == "snacks_terminal"
  end,
  init = function(self)
    -- Terminal names look like term://path/to/cwd//1234:/bin/zsh
    -- We want the part after the last slash
    local tname = vim.api.nvim_buf_get_name(0)
    self.term_title = tname:match(".*[:/](.*)") or "Terminal"

    -- Get icon for the shell
    self.icon, self.icon_color =
      require("nvim-web-devicons").get_icon_color(self.term_title, self.term_title, { default = true })
  end,
  hl = { fg = colors.bright_fg },
  {
    provider = function(self)
      return " " .. self.icon .. " "
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  },
  {
    provider = function(self)
      return self.term_title .. " "
    end,
  },
}

--[[ local WorkDir = {
  provider = function()
    local icon = "  "
    local cwd = vim.fn.getcwd(0)

    cwd = vim.fn.fnamemodify(cwd, ":~")
    if not conditions.width_percent_below(#cwd, 0.25) then
      cwd = vim.fn.pathshorten(cwd)
    end
    local trail = cwd:sub(-1) == "/" and "" or "/"
    return icon .. cwd .. trail
  end,
  hl = { fg = "blue", bold = true },
  update = {
    "DirChanged",
    "BufNew",
    "BufEnter",
    "BufWinEnter",
    callback = function()
      vim.cmd("redrawstatus")
    end,
  },
} ]]

local OilStatus = {
  condition = function()
    return vim.bo.filetype == "oil"
  end,
  provider = function()
    local icon = "  "
    local cwd = vim.fn.getcwd(0)

    local ok, oil = pcall(require, "oil")
    if ok then
      ---@diagnostic disable-next-line
      cwd = oil.get_current_dir()
    end

    cwd = vim.fn.fnamemodify(cwd, ":~")
    local trail = cwd:sub(-1) == "/" and "" or "/"
    return icon .. cwd .. trail
  end,
  hl = { fg = "blue", bold = true },
  update = {
    "DirChanged",
    "BufNew",
    "BufEnter",
    "BufWinEnter",
    callback = function()
      vim.cmd("redrawstatus")
    end,
  },
}

local leftBlock = {
  condition = function()
    return not vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
  end,
  hl = { bg = colors.dark_bg, fg = colors.bright_bg },
  Diagnostics,
  { -- Separator
    provider = "│",
    condition = function(_)
      -- we only need the separator if both are present
      return conditions.has_diagnostics() and has_git_changes()
    end,
    hl = { fg = colors.dark_fg },
  },
  GitDiff,
}

local rightBlock = {
  condition = function()
    return not vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
  end,
  Ruler,
  {
    hl = {
      fg = colors.blue,
      bg = colors.dark_bg,
    },
    Percentage,
  },
  {
    condition = function()
      return vim.bo.filetype ~= "help"
    end,
    GitBranch,
  },
}

M.StatusLine = {
  hl = {
    bg = colors.bright_bg,
    fg = colors.bright_fg,
  },
  { -- show branch when in fugitive
    condition = function()
      return vim.bo.filetype == "fugitive"
    end,
    GitBranch,
    { provider = "%=" }, -- End of left side
  },
  { -- git branch will replace this when in fugitive
    condition = function()
      return vim.bo.filetype ~= "fugitive"
    end,
    ViMode,
  },
  leftBlock,
  {
    fallthrough = true,
    {
      hl = {
        bg = colors.dark_bg,
        fg = colors.bright_fg,
      },
      HelpFileName,
      TerminalName,
    },
    OilStatus,
    FileNameBlock,
  },
  { provider = "%=" }, -- End of left side
  rightBlock,
}

return M
