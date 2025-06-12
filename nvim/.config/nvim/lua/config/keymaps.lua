-- Basic keymaps that are not plugin-specific

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Copy Current Full File Path to Clipboard
vim.keymap.set('n', '<leader>cfp', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('Copied path: ' .. path)
end, { desc = 'Copy full file path' })

-- Copy Current Relative File Path to Clipboard
vim.keymap.set('n', '<leader>crfp', function()
  local path = vim.fn.expand '%'
  vim.fn.setreg('+', path)
  print('Copied path: ' .. path)
end, { desc = 'Copy relative file path' })

-- MAPPING REDO
vim.keymap.set('n', '<C-r>', ':redo<CR>', { desc = 'Redo an action' })

-- GO TO NEXT BUFFER ON WINDOW
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { desc = '[B]uffer [N]ext on current window' })
-- GO TO PREVIOUS BUFFER ON WINDOW
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { desc = '[B]uffer [P]revious on current window' })
-- MOVE LINE UP
vim.keymap.set('n', '<S-k>', ':m .-2<CR>==', { desc = 'Move current line Up' })
-- MOVE LINE DOWN
vim.keymap.set('n', '<S-j>', ':m .+1<CR>==', { desc = 'Move current line Down' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Load Avante keymaps
require('config.avante_keymaps').setup()