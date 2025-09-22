require("config.lazy")

-- highlight the line currently under cursor
vim.opt.cursorline = true

-- spell checking if you want it
vim.opt.spell = false
vim.opt.spellfile = vim.fn.expand("$HOME/.spellfile.add")

-- set the spelling language
vim.opt.spelllang = { "en_gb" }

-- number of spaces that a <Tab> counts for
vim.opt.tabstop = 2

-- convert tabs to spaces
vim.opt.expandtab = true

-- number of spaces to use for each step of (auto)indent
vim.opt.shiftwidth = 2

-- number of spaces a <Tab> feels like when editing
vim.opt.softtabstop = 2

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

-- get HOME
local my_home = os.getenv("HOME")  -- or vim.fn.expand("$HOME")

vim.lsp.config['nextflow'] = {
  cmd = { 'java', '-jar', my_home .. '/opt/nfls/25.04.3/language-server-all.jar' },
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

-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/pyright.lua
vim.lsp.config.pyright = {
  cmd = { my_home .. '/lib/bin/pyright-langserver', '--stdio' },
  filetypes = { 'python' }
}
vim.lsp.enable 'pyright'

vim.lsp.config.bashls = {
  cmd = { my_home .. '/lib/bin/bash-language-server', 'start' },
  filetypes = { 'bash', 'sh' }
}
vim.lsp.enable 'bashls'

-- https://autotools-language-server.readthedocs.io/en/latest/resources/configure.html#neovim
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "configure.ac" },
  callback = function()
    vim.lsp.start({
      name = "config",
      cmd = { "config-language-server" }
    })
  end,
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "Makefile.am", "Makefile" },
  callback = function()
    vim.lsp.start({
      name = "make",
      cmd = { "make-language-server" }
    })
  end,
})

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
-- format the current buffer
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format' })

-- listing shortcuts here for convenience
-- ]d   " go to next diagnostic (error, warning, hint, info)
-- [d   " go to previous diagnostic

-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#modules
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "r", "python", "bash", "groovy", "make", "perl", "sql", "yaml", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "powershell" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "powershell" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
