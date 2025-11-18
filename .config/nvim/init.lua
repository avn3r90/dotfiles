-- ============================================================================
-- Minimalny config Neovim oparty o Lazy.nvim
-- Funkcje: motyw, nerd icons, statusline, autocomplete, telescope, treesitter, file explorer
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. Bootstrap Lazy.nvim
-- ---------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ---------------------------------------------------------------------------
-- 2. Podstawowe opcje
-- ---------------------------------------------------------------------------
vim.o.number = true
vim.o.relativenumber = true
vim.o.syntax = "on"
vim.o.termguicolors = true

-- ---------------------------------------------------------------------------
-- 3. Pluginy
-- ---------------------------------------------------------------------------
require("lazy").setup({

  ---------------------------------------------------------------------------
  -- Motyw
  ---------------------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  ---------------------------------------------------------------------------
  -- Ikony
  ---------------------------------------------------------------------------
  { "nvim-tree/nvim-web-devicons" },

  ---------------------------------------------------------------------------
  -- Statusline
  ---------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin", icons_enabled = true },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Treesitter (składnia)
  ---------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- Fuzzy Finder (Telescope)
  ---------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  ---------------------------------------------------------------------------
  -- File Explorer (oil.nvim)
  ---------------------------------------------------------------------------
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  ---------------------------------------------------------------------------
  -- Autocomplete (nvim-cmp)
  ---------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

})

