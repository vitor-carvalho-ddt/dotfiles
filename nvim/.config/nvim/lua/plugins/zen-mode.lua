-- Zen Mode for distraction-free coding
return {
  'folke/zen-mode.nvim',
  opts = {
    -- Configuration options for zen-mode
    window = {
      backdrop = 0.95,
      width = 0.85,
      height = 0.85,
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
      },
      twilight = { enabled = false },
      gitsigns = { enabled = false },
    },
  },
  keys = {
    { '<leader>zm', ':ZenMode<CR>', desc = 'Open [Z]en [M]ode' },
  },
}