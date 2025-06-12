-- Colorscheme
return {
  'catppuccin/nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins
  name = 'catppuccin',
  init = function()
    -- Load the colorscheme
    vim.cmd.colorscheme 'catppuccin'

    -- Configure highlights
    vim.cmd.hi 'Comment gui=none'
  end,
}
