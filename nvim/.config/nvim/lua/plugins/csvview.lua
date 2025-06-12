-- CSV Viewer plugin 
return {
  'vidocqh/data-viewer.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim'
  },
  keys = {
    {
      '<leader>csv',
      ":CsvViewToggle delimiter=; quote_char=' comment=# display_mode=border<CR>",
      desc = 'Toggle CSV View with comma delimiter and quote char with border'
    },
  },
  opts = {
    autoformat = true,
    preview = {
      width = 40,
      height = 20,
    },
  },
}