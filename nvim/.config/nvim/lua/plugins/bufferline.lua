-- Buffer line at the top of the editor for managing buffers like tabs
return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      mode = 'buffers',
      diagnostics = 'nvim_lsp',
      separator_style = 'thin',
      show_buffer_close_icons = true,
      show_close_icon = false,
      color_icons = true,
      always_show_bufferline = true,
    },
  },
  keys = {
    {
      '<leader>bD',
      ':BufferLineCloseOthers<CR>',
      desc = 'Close other buffers',
    },
  },
}
