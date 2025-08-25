require("config.lazy")

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

-- https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources#use-cr-to-confirm-completion
-- Confirm completion with <CR>
vim.keymap.set("i", "<CR>", function()
  return vim.fn["coc#pum#visible"]() == 1
    and vim.fn["coc#pum#confirm"]()
    or "\r"
end, { expr = true, noremap = true })

-- <CR> selects the first item and confirms if nothing is selected
vim.keymap.set("i", "<CR>", [[coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"]],
  { expr = true, noremap = true, silent = true })

-- Navigate completion list with <Tab> and <S-Tab>
vim.keymap.set("i", "<Tab>", [[coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"]],
  { expr = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"]],
  { expr = true, noremap = true })

