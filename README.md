# flix.nvim

- neovim support for [Flix](https://flix.dev/)

## Functionality

- Flix leverages LSP for syntax highlighting and as a result a dependency of **flix.nvim** is [lspconfig](https://github.com/neovim/nvim-lspconfig)

- this plugin serves three main purposes
    1. simplify setting up `lspconfig` for Flix
    2. set the Flix filetype and language defaults
    3. lua functions for interacting with the Flix cli

## installation

- using your package manager of choice pass in the repo
    - "flix/flix.nvim"

## LSP

- to get the lsp setup you must import the `flix.lsp` module and call it's functions
    - it is recommended to do this where you setup other LSP servers, usually when configuring `lspconfig`, so that you can use the same `capabilities` and `on_attatch` as used accross your configuration.
    - for reference
        - `capabilities` => sets up your completion functionality depending on your plugin of choice
        - `on_attach` => sets up your keybindings for LSP functionality

```lua
-- create Flix config
require("flix.lsp").set_config()
-- setup server
require("flix.lsp").flix_lsp(capabilities, on_attach)
```

## Commands

- you can set local Flix keybindings with an autocommand or by creating `ftplugin/flix.lua` in your configuration.
- the following example shows how to setup keybindings for running and testing a flix project

```lua
-- import the `flix_cmd` function
local flix_cmd = require("flix.commands").flix_cmd
-- setting `bufnr` prevents keybindings from being set to other filetypes
local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set('n', '<Space>br', function() flix_cmd("run") end,
  { noremap = true, silent = true, buffer = bufnr, desc = "run flix project" })
vim.keymap.set('n', '<Space>bt', function() flix_cmd("test") end,
  { noremap = true, silent = true, buffer = bufnr, desc = "run flix project" })
```

