-- Icons for Neovim plugins
return {
  'nvim-tree/nvim-web-devicons',
  lazy = true,
  opts = {
    -- globally enable different highlight colors per icon
    color_icons = true,
    -- globally enable default icons (default to `true`)
    default = true,
    -- globally enable "strict" selection of icons - icon will be looked up in
    -- different tables, first by filename, and if not found by extension; this
    -- prevents cases when file doesn't have any extension but still gets some icon
    strict = true,
  },
}