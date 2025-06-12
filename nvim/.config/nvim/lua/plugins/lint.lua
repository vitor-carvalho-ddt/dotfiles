-- Linting plugin for Neovim
return {
  'mfussenegger/nvim-lint',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require('lint')
    
    lint.linters_by_ft = {
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      python = { 'flake8' },
      -- lua = { 'luacheck' }, -- Commented out until luacheck is installed
      -- Add more file types and linters as needed
    }
    
    -- Create an autocmd to trigger linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
    
    -- Add keymap to trigger linting manually
    vim.keymap.set('n', '<leader>cl', function()
      require('lint').try_lint()
    end, { desc = '[C]ode [L]int' })
  end,
}