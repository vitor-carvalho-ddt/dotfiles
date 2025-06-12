-- Minimal init.lua for Neovim
-- Set leader key early to ensure it's available for all configurations
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load the configuration modules
require('config.options')    -- General Neovim settings and options 
require('config.keymaps')    -- Non-plugin keymaps
require('config.lazy')       -- Plugin manager and plugin specs