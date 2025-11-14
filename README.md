# Neovim Configuration

My personal [Neovim](https://github.com/neovim/neovim) configuration files
which was a fork of
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). A lot of stuff
here is inspired by [NvChad](https://github.com/NvChad/NvChad), which is
how I got into Neovim.

## Prerequisites

> Targets only the latest stable Neovim.

Run `:checkhealth` to check for any missing dependencies or issues.

- git
- curl
- make
- ripgrep
- unzip
- zoxide (optional)

## Structure

```sh
.
├── after
│   └── ftplugin
│       └── filetype.lua    # filetype based config
├── lua
│   ├── configs
│   │   └── ...             # configfiles
│   ├── plugins
│   │   ├── core
│   │   │   └── ...         # core plugins
│   │   └── custom
│   │       └── ...         # custom plugins
│   ├── ascii.lua
│   ├── autocmds.lua
│   ├── mappings.lua        # keymaps
│   ├── neovide.lua         # neovide settings here
│   └── options.lua         # vim options
├── init.lua
├── lazy-lock.json
├── LICENSE.md
└── README.md
```

## Links

- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [NvChad](https://github.com/NvChad/NvChad)
