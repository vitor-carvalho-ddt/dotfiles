-- Extra keymaps for Avante.nvim
local M = {}

M.setup = function()
  -- These are additional keymaps that can be useful when using Avante
  -- You can modify or add more keymaps as needed
  
  -- Ask AI about your code
  vim.keymap.set('n', '<leader>aq', function()
    vim.cmd('AvanteAsk')
  end, { desc = 'Avante: Ask AI about code' })
  
  -- Start a new chat session
  vim.keymap.set('n', '<leader>an', function()
    vim.cmd('AvanteChatNew')
  end, { desc = 'Avante: Start new chat' })
  
  -- Clear chat history
  vim.keymap.set('n', '<leader>ax', function()
    vim.cmd('AvanteClear')
  end, { desc = 'Avante: Clear chat history' })
  
  -- Show repo map
  vim.keymap.set('n', '<leader>ap', function()
    vim.cmd('AvanteShowRepoMap')
  end, { desc = 'Avante: Show repository map' })
  
  -- Edit selected code blocks
  vim.keymap.set('n', '<leader>ae', function()
    vim.cmd('AvanteEdit')
  end, { desc = 'Avante: Edit selected blocks' })
end

return M
