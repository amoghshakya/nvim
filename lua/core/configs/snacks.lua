local M = {}

M.keys = {
  -- Explorer
  {
    "<C-n>",
    function()
      Snacks.explorer.open()
    end,
    desc = "Toggle Explorer",
  },
  -- Lazygit
  {
    "<leader>lg",
    function()
      Snacks.lazygit()
    end,
    desc = "[L]azy[g]it",
  },
  -- Picker
  {
    "<leader>st",
    function()
      ---@diagnostic disable-next-line: undefined-field
      Snacks.picker.todo_comments({
        layout = {
          preset = "vertical",
        },
      })
    end,
    desc = "[S]earch [T]odo",
  },
  {
    "<leader>sf",
    function()
      Snacks.picker.files()
    end,
    desc = "[S]earch [F]iles",
  },
  {
    "<leader>sk",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "[S]earch [K]eymaps",
  },
  {
    "<leader>sh",
    function()
      Snacks.picker.help()
    end,
    desc = "[S]earch [H]elp",
  },
  {
    "<leader>sg",
    function()
      Snacks.picker.grep()
    end,
    desc = "[S]earch [G]rep",
  },
  {
    "<leader>ss",
    function()
      Snacks.picker()
    end,
    desc = "[S]earch [S]elect",
  },
  {
    "<leader>sw",
    function()
      Snacks.picker.grep_word()
    end,
    desc = "[S]earch current [W]ord",
  },
  {
    "<leader>sr",
    function()
      Snacks.picker.resume()
    end,
    desc = "[S]earch [R]esume",
  },
  {
    "<leader>s.",
    function()
      Snacks.picker.recent()
    end,
    desc = "[S]earch Recent Files ('.' for repeat)",
  },
  {
    "<leader>sd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "[S]earch [D]iagnostics",
  },
  {
    "<leader>sc",
    function()
      Snacks.picker.colorschemes()
    end,
    desc = "[S]earch [C]olorschemes",
  },
  {
    "<leader>sp",
    function()
      Snacks.picker.zoxide({
        title = "Projects",
        layout = {
          preset = "vscode",
        },
      })
    end,
    desc = "[S]earch [P]rojects",
  },
  {
    "<leader>sn",
    function()
      Snacks.picker.files({
        cwd = vim.fn.stdpath("config"),
        title = "Neovim Configs",
      })
    end,
    desc = "[S]earch [N]eovim Configs",
  },
  {
    "<leader>/",
    function()
      Snacks.picker.lines()
    end,
    desc = "[/] Fuzzily search in current buffer",
  },
  {
    "<leader>s/",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "[S]earch [/] in Open Files",
  },
  {
    "<leader><leader>",
    function()
      Snacks.picker.buffers()
    end,
    desc = "[ ] Find existing buffers",
  },
  {
    "<leader>gl",
    function()
      Snacks.picker.git_log({
        layout = "vertical",
      })
    end,
    desc = "[G]it [L]ogs",
  },
  {
    "<leader>ft",
    function()
      -- This is a custom picker defined in the config below
      ---@diagnostic disable-next-line
      Snacks.picker.filetypes()
    end,
    desc = "[F]ile[t]ypes",
  },
  -- Terminal toggles
  {
    "<A-`>",
    function()
      local last = vim.g.last_horizontal_term
      if not last then
        local unique_env = { CREATED_AT = tostring(os.time()) }
        vim.g.last_horizontal_term = { cmd = nil, cwd = nil, env = unique_env, count = vim.v.count1 }
        Snacks.terminal.toggle(nil, {
          env = unique_env,
          interactive = true,
          auto_close = false,
          win = {
            position = "bottom",
            split = "below",
            height = 0.4,
          },
        })
        return
      end
      Snacks.terminal.toggle(last.cmd, {
        env = last.env,
        cwd = last.cwd,
        interactive = true,
        auto_close = false,
        win = {
          position = "bottom",
          split = "below",
          height = 0.4,
        },
      })
    end,
    desc = "Snacks: Horizontal Terminal",
    mode = { "n", "t" },
  },
  {
    "<A-v>",
    function()
      local last = vim.g.last_vertical_term
      if not last then
        local unique_env = { CREATED_AT = tostring(os.time()) }
        vim.g.last_vertical_term = { cmd = nil, cwd = nil, env = unique_env, count = vim.v.count1 }
        Snacks.terminal.toggle(nil, {
          env = unique_env,
          interactive = true,
          auto_close = false,
          win = {
            position = "right",
            split = "right",
            width = 0.4,
          },
        })
        return
      end
      Snacks.terminal.toggle(last.cmd, {
        env = last.env,
        cwd = last.cwd,
        interactive = true,
        auto_close = false,
        win = {
          position = "right",
          split = "right",
          width = 0.4,
        },
      })
    end,
    desc = "Snacks: Vertical Terminal",
    mode = { "n", "t" },
  },
  {
    "<A-i>",
    function()
      Snacks.terminal.toggle(nil, {
        env = {
          SNACKS_TERM = "float",
        },
        interactive = true,
        auto_close = false,
        win = {
          position = "float",
          border = "rounded",
          width = 0.8,
          height = 0.7,
        },
      })
    end,
    desc = "Snacks: Floating Terminal",
    mode = { "n", "t" },
  },
  -- Terminal create
  {
    "<leader>nh",
    function()
      local unique_env = { CREATED_AT = tostring(os.time()) }
      local term, _ = Snacks.terminal.get(nil, {
        interactive = true,
        auto_close = false,
        win = {
          position = "bottom",
          split = "below",
          height = 0.4,
        },
        env = unique_env,
      })
      ---@diagnostic disable-next-line: need-check-nil
      term:show()
      -- Store the ID info for toggle later
      vim.g.last_horizontal_term = { cmd = nil, cwd = nil, env = unique_env, count = vim.v.count1 }
    end,
    desc = "[N]ew [H]orizontal Terminal",
  },
  {
    "<leader>nv",
    function()
      local unique_env = { CREATED_AT = tostring(os.time()) }
      local term, _ = Snacks.terminal.get(nil, {
        interactive = true,
        auto_close = false,
        win = {
          position = "right",
          split = "right",
          width = 0.4,
        },
        env = unique_env,
      })
      ---@diagnostic disable-next-line: need-check-nil
      term:show()
      -- Store the ID info for toggle later
      vim.g.last_vertical_term = { cmd = nil, cwd = nil, env = unique_env, count = vim.v.count1 }
    end,
    desc = "[N]ew [V]ertical Terminal",
  },
}

---@type snacks.picker.Config
M.picker = {
  enabled = true,
  prompt = "   ",
  layout = {
    cycle = false,
  },
  matcher = {
    frecency = true,
  },
  layouts = {
    default = {
      layout = {
        box = "horizontal",
        width = 0.8,
        min_width = 120,
        height = 0.8,
        backdrop = false,
        {
          box = "vertical",
          border = "solid",
          title = "{title} {live} {flags}",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
        { win = "preview", title = "{preview}", border = "solid", width = 0.5 },
      },
    },
    vertical = {
      layout = {
        backdrop = false,
        width = 0.8,
        min_width = 80,
        height = 0.8,
        min_height = 30,
        box = "vertical",
        border = "solid",
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
      },
    },
  },
  sources = {
    files = {
      hidden = true,
      ignored = true,
      exclude = {
        "**/.git/*",
        "**/node_modules/*",
        "**/vendor/*",
        "**/.cache/*",
        "**/.DS_Store",
        "**/.idea/*",
        "**/.vscode/*",
        "**/.sass-cache/*",
        "**/.next/*",
        "**/dist/*",
        "**/build/*",
        "**/*cache*", -- anything that has the cache in the name
        "**/.virtual_documents",
      },
    },
    filetypes = {
      name = "filetypes",
      format = "text",
      preview = "none",
      layout = { preset = "vscode" },
      confirm = function(picker, item)
        picker:close()
        if item then
          vim.schedule(function()
            vim.cmd("setfiletype " .. item.text)
          end)
        end
      end,
      finder = function()
        local items = {}
        local filetypes = vim.fn.getcompletion("", "filetype")
        for _, type in ipairs(filetypes) do
          items[#items + 1] = {
            text = type,
          }
        end
        return items
      end,
    },
    terminals = {
      name = "terminals",
      format = "text",
      preview = "none",
      layout = { preset = "vscode" },
      finder = function()
        local terms = Snacks.terminal.list()
        local items = {}

        for _, t in ipairs(terms) do
          local pos = t.opts and t.opts.position or "unknown"
          local vis = t.closed and "[hidden]" or "[visible]"
          local name = vim.api.nvim_buf_get_name(t.buf)
          local short_name = vim.fn.fnamemodify(name, ":t")

          if short_name == "" then
            short_name = "[no name]"
          end

          table.insert(items, {
            text = string.format(" [%d] %-8s %-9s %s", t.id or 0, pos, vis, short_name),
            buf = t.buf,
            win = t.win,
            closed = t.closed,
            value = t,
          })
        end

        return items
      end,
      confirm = function(picker, item)
        picker:close()
        if item and item.value then
          vim.schedule(function()
            local term = item.value
            if term.closed then
              term:show()
            else
              term:focus()
            end
          end)
        end
      end,
    },
    pickers = {
      finder = "meta_pickers",
      format = "text",
      layout = {
        preset = "vscode",
      },
    },
    colorschemes = {
      finder = "vim_colorschemes",
      format = "text",
      preview = "colorscheme",
      layout = {
        preset = "vscode",
      },
      on_change = function(_, item)
        if item then
          vim.cmd("colorscheme " .. item.text)
        end
      end,
      confirm = function(picker, item)
        picker:close()
        if item then
          picker.preview.state.colorscheme = nil
          vim.schedule(function()
            vim.cmd("colorscheme " .. item.text)
          end)
        end
      end,
    },
    keymaps = {
      layouts = {
        default = {
          layout = {
            box = "vertical",
            width = 0.8,
            height = 0.8,
            {
              box = "vertical",
              border = "solid",
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
      },
    },
    ---@type snacks.picker.explorer.Config
    explorer = {
      layout = {
        layout = {
          position = "right",
        },
      },
      win = {
        list = {
          keys = {
            ["<C-n>"] = function()
              Snacks.explorer.open()
            end,
            ["w"] = "explorer_cd",
          },
        },
      },
    },
  },
}

local header_art = (tonumber(os.date("%m")) == 10) and require("ascii").bloody or require("ascii").sharp
---@type snacks.dashboard.Config
M.dashboard = {
  enabled = true,
  preset = {
    header = table.concat(header_art, "\n"),
  },
}

---@type snacks.terminal.Config
M.terminal = {
  win = {
    style = "minimal",
    backdrop = false,
  },
}

---@type snacks.picker.explorer.Config
M.explorer = {
  enabled = true,
  replace_netrw = true,
}

return M
