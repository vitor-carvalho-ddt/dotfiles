return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  keys = {
    -- blame whole file
    { '<leader>gb', ':Git blame<CR>', desc = '[G]it [B]lame' },
  },
}
