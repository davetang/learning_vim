local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- Any valid git URL is allowed
Plug('https://github.com/junegunn/vim-easy-align.git')

-- Using a non-default branch
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })

-- sensible.vim: Defaults everyone can agree on
-- https://github.com/tpope/vim-sensible
Plug('tpope/vim-sensible')

-- https://github.com/gabrielelana/vim-markdown
Plug('gabrielelana/vim-markdown')

-- Vim script for text filtering and alignment
-- https://github.com/godlygeek/tabular
Plug('godlygeek/tabular')

-- Plug('LukeGoodsell/nextflow-vim')
-- Vim plugin for Nextflow
-- https://github.com/nextflow-io/vim-language-nextflow
Plug('nextflow-io/vim-language-nextflow')

-- https://github.com/rust-lang/rust.vim
Plug('rust-lang/rust.vim')

-- You can clean trailing whitespace with :FixWhitespace.
Plug('bronson/vim-trailing-whitespace')

-- precision colorscheme for the vim text editor
-- https://github.com/altercation/vim-colors-solarized
Plug('altercation/vim-colors-solarized')

-- show which line changed since your last commit
-- A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
-- https://github.com/airblade/vim-gitgutter
Plug('airblade/vim-gitgutter')

-- de facto git plugin
Plug('tpope/vim-fugitive')

-- https://github.com/jalvesaq/Vim-R
Plug('jalvesaq/Nvim-R')

vim.call('plug#end')

-- highlight the line currently under cursor
vim.opt.cursorline = true

-- spell checking if you want it
vim.opt.spell = false
vim.opt.spellfile = vim.fn.expand("$HOME/.spellfile.add")

-- set the spelling language
vim.opt.spelllang = { "en_gb" }

-- number of spaces that a <Tab> counts for
vim.opt.tabstop = 3

-- convert tabs to spaces
vim.opt.expandtab = true

-- number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 3

-- number of spaces a <Tab> feels like when editing
vim.opt.softtabstop = 3

-- copy indent from current line when starting a new one
vim.opt.autoindent = true

-- smarter autoindenting (for things like C)
vim.opt.smartindent = true

-- show cursor position in status line
vim.opt.ruler = true

-- show line numbers
vim.opt.number = true

-- show relative line numbers
vim.opt.relativenumber = true

-- highlight all search matches
vim.opt.hlsearch = true

-- store more :cmdline history
vim.opt.history = 1000

-- disable the mouse
vim.opt.mouse = ""

-- Enable 24-bit RGB colors
-- vim.opt.termguicolors = true

-- Syntax highlighting and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

vim.lsp.enable('nextflow')

vim.lsp.config['nextflow'] = {
  cmd = { 'java', '-jar', '/home/dtang/opt/nfls/25.04.3/language-server-all.jar' },
  filetypes = { 'nextflow', 'nf', 'groovy', 'config' },
  root_markers = { 'nextflow.config', '.git' },
  settings = {
    nextflow = {
      files = {
        exclude = { '.git', '.nf-test', 'work' },
      }
    }
  }
}
