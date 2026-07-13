return {
  "rebelot/heirline.nvim",
  config = function()
    local utils = require("heirline.utils")
    local colors = function()
      local function get_fg(group, fallback)
        local hl = utils.get_highlight(group)
        return hl and hl.fg or utils.get_highlight(fallback).fg
      end

      return {
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
        git_del = get_fg("@diff.minus", "DiffDelete"),
        git_add = get_fg("@diff.plus", "DiffAdd"),
        git_change = get_fg("@diff.delta", "DiffChange"),
      }
    end

    require("heirline").load_colors(colors())
    require("heirline").setup({
      statusline = require("configs.statusline").StatusLine,
      tabline = require("configs.tabline").TabLine,
    })

    vim.api.nvim_create_augroup("Heirline", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        utils.on_colorscheme(colors())
      end,
      group = "Heirline",
    })
  end,
}
