return { -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    -- [[ Configure Treesitter ]]
    -- See `:help nvim-treesitter`
    config = function()
      local ts = require("nvim-treesitter")
      local ensure_installed = {
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "python",
        "luadoc",
        "markdown",
        "json",
      }
      local available = ts.get_available()
      local installed = ts.get_installed("parsers")
      local parsers_to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(installed, parser)
        end)
        :totable()
      ts.install(parsers_to_install)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then
          return
        end
        vim.treesitter.start(buf, language)
        local has_indent_query = vim.treesitter.query.get(language, "indent") ~= nil
        if has_indent_query then
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end
          -- re-fetch installed at callback time so newly installed parsers are picked up
          local current_installed = ts.get_installed("parsers")
          if vim.tbl_contains(current_installed, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available, language) then
            ts.install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            treesitter_try_attach(buf, language)
          end
        end,
      })
    end,
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      mode = "cursor",
      max_lines = 5,
    },
  },
}
