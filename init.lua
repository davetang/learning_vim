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
vim.lsp.enable('nextflow')

vim.lsp.config.bashls = {
  cmd = { '/home/dtang/lib/bin/bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' }
}
vim.lsp.enable 'bashls'

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

-- Set leader to space
vim.g.mapleader = " "

-- LSP keymap bindings
-- vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
-- mode: "n" = normal, "i" = insert, "v" = visual
-- lhs: the key sequence you press
-- rhs: the command or mapping it triggers
-- opts: (optional) a table of options:
--    desc = "..." -> description (shows up in :map and plugins like which-key)
--    silent = true -> don’t echo command
--    noremap = true -> prevent recursive mapping (default for vim.keymap.set)
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
vim.keymap.set("n", "<leader>fe", ":Explore<CR>", { desc = "Open file explorer" })
-- https://livesys.se/posts/nextflow-lsp-with-neovim/
-- Go to definition when you want to jump to where something is defined.
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
-- rename the symbol under your cursor everywhere it appears.
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
-- Find references to see where it is used.
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find References' })

-- listing shortcuts here for convenience
-- ]d   " go to next diagnostic (error, warning, hint, info)
-- [d   " go to previous diagnostic
