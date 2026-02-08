-- Highlight, edit, and navigate code
return {
  'nvim-treesitter/nvim-treesitter',
  opts = {
    -- add more treesitter parsers
    ensure_installed = {
      'bash',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'tsx',
      'typescript',
      'vim',
      'yaml',
    },
  },
}
