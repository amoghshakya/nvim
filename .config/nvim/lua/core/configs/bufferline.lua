local M = {}

M.opts = function()
  return {
    options = {
      themable = true,
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = true,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      persist_buffer_sort = true,
      -- separator_style = { "", "" },
      separator_style = "thin",
      always_show_bufferline = true,
      color_icons = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      modified_icon = "",
      diagnostics = "nvim_lsp", -- show LSP diagnostics in tab
      diagnostics_indicator = function(_, _, diag)
        local icons = {
          Error = " ",
          Warn = " ",
          Hint = " ",
          Info = " ",
        }
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,
      custom_filter = function(buf, _)
        local exclude = { "quickfix", "nofile" }
        local buftype = vim.bo[buf].buftype

        return not vim.tbl_contains(exclude, buftype)
      end,
      offsets = {
        {
          filetype = "snacks_layout_box",
          text = "",
          separator = true,
        },
        {
          filetype = "help",
          text = "",
          separator = false,
        },
      },
      name_formatter = function(buf)
        local name = buf.name
        local path = buf.path

        local filename = vim.fn.fnamemodify(name, ":t")
        local is_index = filename:match("^index%.[tj]sx$")

        if is_index then
          local dirname = vim.fn.fnamemodify(path, ":h:t")
          return dirname .. " - Component"
        end

        return filename
      end,
    },
  }
end

M.keys = {
  { "<leader>pb", "<CMD>BufferLinePick<CR>", desc = "[P]ick [B]uffer", silent = true },
}

return M
