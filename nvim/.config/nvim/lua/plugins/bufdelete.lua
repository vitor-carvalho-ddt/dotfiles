-- Buffer delete without closing window
return {
  'famiu/bufdelete.nvim',
  keys = {
    {
      '<leader>bd',
      function()
        require('bufdelete').bufdelete(0, true)
      end,
      desc = '[B]uffer [D]elete (no window close)',
    },
  },
}
