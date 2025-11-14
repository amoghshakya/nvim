local M = {}

local excluded_filetypes = {
  "TelescopePrompt",
  "snacks_dashboard",
  "snacks_picker_input",
  "snacks_picker_list",
  "snacks_layout_box",
  "snacks_terminal",
  "fugitive",
}

local exclude = function()
  return not vim.tbl_contains(excluded_filetypes, vim.bo.filetype)
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

M.opts = {
  options = {
    -- Disable sections and component separators
    component_separators = "│",
    section_separators = "",
    globalstatus = true, -- single statusline across splits
    always_show_tabline = false,
    disabled_filetypes = {
      statusline = { "lazy", "mason" },
      winbar = {},
    },
  },
  refresh = {
    statusline = 100,
    tabline = 100,
    winbar = 100,
  },
  -- tabline = {
  --   lualine_a = {},
  --   lualine_z = {
  --     {
  --       "tabs",
  --       cond = function()
  --         -- show tabline only if there are multiple tabs
  --         return vim.fn.tabpagenr("$") > 1
  --       end,
  --     },
  --   },
  -- },
  sections = {
    lualine_a = {
      {
        "mode",
        icons_enabled = false,
        icon = "",
        -- fmt = function(str)
        --   return str:sub(1, 3) -- or str:sub(1, 1)
        -- end,
      },
    },
    lualine_b = {
      "diagnostics",
      {
        "diff",
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
        },
      },
    },
    lualine_c = {
      {
        "filetype",
        icon_only = true,
        separator = "",
        padding = { left = 1, right = 0 },
        cond = exclude,
      },
      {
        "filename",
        cond = function()
          return conditions.buffer_not_empty() and exclude()
        end,
        padding = { left = 1, right = 1 },
      },
    },
    lualine_x = {
      -- "lsp_status",
      "location",
    },
    lualine_y = {
      "progress",
    },
    lualine_z = {
      {
        "branch",
        icon = "",
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {
    "quickfix",
    "nvim-dap-ui",
    "fugitive",
    "man",
    "mason",
    "lazy",
    "oil",
  },
}

return M
