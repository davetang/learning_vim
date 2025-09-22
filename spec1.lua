-- This file should be in ~/.config/nvim/lua/plugins
-- run `:Lazy sync` after making changes to sync to latest changes
return {

  -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Installation#lazy
  -- :NvimTreeToggle Open or close the tree. Takes an optional path argument.
  -- :NvimTreeFocus Open the tree if it is closed, and then focus on the tree.
  -- :NvimTreeFindFile Move the cursor in the tree for the current buffer, opening folders if needed.
  -- :NvimTreeCollapse Collapses the nvim-tree recursively.
  {
     "nvim-tree/nvim-tree.lua",
     version = "*",
     lazy = false,
     dependencies = {
        "nvim-tree/nvim-web-devicons",
     },
     config = function()
        require("nvim-tree").setup {}
     end,
  },

  -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#installation
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate"
  },

  -- https://github.com/folke/which-key.nvim?tab=readme-ov-file#-installation
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "tpope/vim-sensible"
  },

  {
    "neovim/nvim-lspconfig"
  },

  -- https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#using-lazynvim
  { 'neoclide/coc.nvim', branch = 'release'},

  {
    "junegunn/vim-easy-align"
  },

  -- Vim script for text filtering and alignment
  {
    "godlygeek/tabular"
  },

  {
    "nextflow-io/vim-language-nextflow"
  },

  -- You can clean trailing whitespace with :FixWhitespace.
  {
    "bronson/vim-trailing-whitespace"
  },

  {
    "airblade/vim-gitgutter"
  },

  -- use the plugin in the on-the-fly mode use
  -- :TableModeToggle
  -- mapped to <Leader>tm by default (which means `\tm`)
  { "dhruvasagar/vim-table-mode" },

  {
    "altercation/vim-colors-solarized"
  },

  -- https://github.com/preservim/vim-markdown
  -- Folding is enabled for headers by default.
  -- `zR`: opens all folds
  { "preservim/vim-markdown" },

  {
    "jalvesaq/Nvim-R"
  },

  {
    "tpope/vim-fugitive"
  }

}
