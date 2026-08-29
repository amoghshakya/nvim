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
      return { fg = "bright_bg", bg = "dark_bg" }
    end
  end,
}

local TabpageClose = {
  provider = "%999X  %X",
  hl = { fg = "red" },
}

local TabPages = {
  condition = multi_tab_condition,
  { provider = " " },
  { provider = "%=" },
  hl = {
    bg = "bright_bg",
    fg = "bright_fg",
  },
  {
    provider = " TABS ",
    hl = {
      fg = "bright_bg",
      bg = "blue",
    },
  },
  { provider = " " },
  utils.make_tablist(Tabpage),
  { provider = " " },
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

local TablineFileName = {
  provider = function(self)
    local filename = self.filename
    filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
    return " " .. filename
  end,
  hl = function(self)
    return {
      bold = self.is_active or self.is_visible,
      italic = false,
    }
  end,
}

-- Diagnostics
local TablineDiagnostics = {
  init = function(self)
    -- Safely fetch icons from the config
    local config = vim.diagnostic.config() or {} -- lua ls might complain otherwise
    -- Defensive check: if signs isn't a table with text
    local signs = (type(config.signs) == "table" and config.signs.text)
      or require("configs.lsp").diagnostics.signs.text -- this definitely exists
      or {} -- add this so lsp doesn't go crazy on us

    self.symbols = {
      [vim.diagnostic.severity.ERROR] = signs[vim.diagnostic.severity.ERROR] or "E",
      [vim.diagnostic.severity.WARN] = signs[vim.diagnostic.severity.WARN] or "W",
      [vim.diagnostic.severity.INFO] = signs[vim.diagnostic.severity.INFO] or "I",
      [vim.diagnostic.severity.HINT] = signs[vim.diagnostic.severity.HINT] or "H",
    }

    -- Fetch diagnostics for the specific buffer this tab represents
    local diagnostics = vim.diagnostic.get(self.bufnr)
    local count = { 0, 0, 0, 0 }
    for _, diagnostic in ipairs(diagnostics) do
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
    self.errors = count[vim.diagnostic.severity.ERROR]
    self.warnings = count[vim.diagnostic.severity.WARN]
    self.hints = count[vim.diagnostic.severity.HINT]
    self.info = count[vim.diagnostic.severity.INFO]
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = function(self)
      return self.errors > 0 and self.symbols[vim.diagnostic.severity.ERROR]
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and self.symbols[vim.diagnostic.severity.WARN]
    end,
    hl = { fg = "diag_warn" },
  },
  -- not going to show hints and info for now, but leaving the code here in case I change my mind
  -- {
  --   provider = function(self)
  --     return self.info > 0 and self.symbols[vim.diagnostic.severity.INFO]
  --   end,
  --   hl = { fg = "diag_info" },
  -- },
  -- {
  --   provider = function(self)
  --     return self.hints > 0 and self.symbols[vim.diagnostic.severity.HINT]
  --   end,
  --   hl = { fg = "diag_hint" },
  -- },
}

-- Here the filename block finally comes together
local TablineFileNameBlock = {
  init = function(self)
    local ok, name = pcall(vim.api.nvim_buf_get_name, self.bufnr)
    self.filename = ok and name or ""
    local ok2, modified = pcall(vim.api.nvim_get_option_value, "modified", { buf = self.bufnr })
    self.is_modified = ok2 and modified or false
  end,
  hl = function(self)
    if self.is_active then
      return "TabLineSel"
      -- why not?
    elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
      return { fg = "gray" }
    else
      return "TabLine"
    end
  end,
  on_click = {
    callback = function(_, minwid, _, button)
      if button == "m" then
        vim.schedule(function()
          pcall(vim.api.nvim_buf_delete, minwid, { force = false })
        end)
      else
        pcall(vim.api.nvim_win_set_buf, 0, minwid)
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
  },
  require("configs.statusline").FileIcon,
  TablineFileName,
  { provider = " " },
  TablineDiagnostics,
}

-- Close button
local TablineCloseButton = {
  provider = function(self)
    local ok, modified = pcall(vim.api.nvim_get_option_value, "modified", { buf = self.bufnr })
    if ok and modified then
      if self.is_active then
        return " ● "
      else
        return " ● "
      end
    else
      local ok2, ro = pcall(vim.api.nvim_get_option_value, "readonly", { buf = self.bufnr })
      local ok3, ma = pcall(vim.api.nvim_get_option_value, "modifiable", { buf = self.bufnr })
      if (ok3 and not ma) or (ok2 and ro) then
        return "   "
      end
      return "   "
    end
  end,
  hl = function(self)
    local ok, modified = pcall(vim.api.nvim_get_option_value, "modified", { buf = self.bufnr })
    if ok and modified then
      return { fg = "green" }
    elseif self.is_active then
      return { fg = "bright_fg" }
    else
      return { fg = "gray" }
    end
  end,
  on_click = {
    callback = function(_, minwid)
      local ok, modified = pcall(vim.api.nvim_get_option_value, "modified", { buf = minwid })
      if not (ok and modified) then
        vim.schedule(function()
          pcall(vim.api.nvim_buf_delete, minwid, { force = false })
          pcall(vim.cmd.redrawtabline)
        end)
      else
        vim.api.nvim_echo({ { "Buffer is modified. Save before closing!", "WarningMsg" } }, false, {})
      end
    end,
    minwid = function(self)
      return self.bufnr
    end,
    name = "heirline_tabline_close_buffer_callback",
  },
}

local TablineBufferBlock = {
  {
    utils.surround({ "", "" }, function(self)
      if self.is_active then
        return utils.get_highlight("TabLineSel").bg
      else
        return utils.get_highlight("TabLine").bg
      end
    end, { TablineFileNameBlock, TablineCloseButton }),
  },
  hl = function(self)
    if self.is_active then
      return { underline = true, sp = "blue" }
    end
  end,
}

-- this is the default function used to retrieve buffers
local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
  end, vim.api.nvim_list_bufs())
end

local buflist_cache = {}

-- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
  callback = function()
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        buflist_cache[i] = v
      end
      for i = #buffers + 1, #buflist_cache do
        buflist_cache[i] = nil
      end

      -- Update showtabline
      if #buflist_cache >= 1 then
        vim.o.showtabline = 2
      elseif vim.o.showtabline ~= 1 then
        vim.o.showtabline = 1
      end

      vim.cmd.redrawtabline()
    end)
  end,
})

local BufferLine = utils.make_buflist(
  TablineBufferBlock,
  { provider = " ", hl = { fg = "blue" } },
  { provider = " ", hl = { fg = "blue" } },
  -- out buf_func simply returns the buflist_cache
  function()
    return buflist_cache
  end,
  -- no cache, as we're handling everything ourselves
  false
)

M.TabLine = {
  -- condition = multi_tab_condition,
  TabLineOffset,
  BufferLine,
  TabPages,
}

-- Yep, with heirline we're driving manual!
vim.o.showtabline = 2 -- 2 means always show tabline
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if vim.tbl_contains({ "wipe", "delete" }, vim.bo.bufhidden) then
      vim.bo.buflisted = false
    end
  end,
})

return M
