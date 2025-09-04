return {
  'ThePrimeagen/git-worktree.nvim',
  event = 'VeryLazy',
  keys = {
    { mode = 'n', '<leader>gws', ':Telescope git_worktree git_worktrees<CR>', desc = 'Show Git Worktrees' },
    { mode = 'n', '<leader>gwc', ':Telescope git_worktree create_git_worktree<CR>', desc = 'Create Git Worktree' },
  },
  config = function()
    require('git-worktree').setup {}
    require('telescope').load_extension 'git_worktree'
  end,
}
