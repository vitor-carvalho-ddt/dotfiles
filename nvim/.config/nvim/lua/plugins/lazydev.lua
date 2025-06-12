-- Configures Lua LSP for Neovim config
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = 'luvit-meta/library', words = { 'vim%.uv' } },
    },
  },
  dependencies = {
    { 'Bilal2453/luvit-meta', lazy = true },
  }
}
