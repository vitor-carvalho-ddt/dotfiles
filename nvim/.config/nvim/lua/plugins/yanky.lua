return {
  'gbprod/yanky.nvim',
  opts = {
    ring = {
      history_length = 100,
      storage = 'shada',
      storage_path = vim.fn.stdpath 'data' .. '/databases/yanky.db', -- Only for sqlite storage
      sync_with_numbered_registers = true,
      cancel_event = 'update',
      ignore_registers = { '_' },
      update_register_on_cycle = false,
      permanent_wrapper = nil,
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
      telescope = {
        use_default_mappings = true, -- if default mappings should be used
        mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
      },
    },
    system_clipboard = {
      sync_with_ring = true,
      clipboard_register = nil,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 500,
    },
    preserve_cursor_position = {
      enabled = true,
    },
    textobj = {
      enabled = false,
    },
  },
  keys = {
    -- Yank and Put
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
    { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
    { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },

    -- Yank Ring Navigation
    { '<c-p>', '<Plug>(YankyPreviousEntry)', mode = 'n', desc = 'Select previous entry through yank history' },
    { '<c-n>', '<Plug>(YankyNextEntry)', mode = 'n', desc = 'Select next entry through yank history' },

    -- Special Put (unimpaired style)
    { ']p', '<Plug>(YankyPutIndentAfterLinewise)', mode = 'n', desc = 'Put indented after cursor (linewise)' },
    { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', mode = 'n', desc = 'Put indented before cursor (linewise)' },
    { ']P', '<Plug>(YankyPutIndentAfterLinewise)', mode = 'n', desc = 'Put indented after cursor (linewise)' },
    { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', mode = 'n', desc = 'Put indented before cursor (linewise)' },

    { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', mode = 'n', desc = 'Put and indent right' },
    { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', mode = 'n', desc = 'Put and indent left' },
    { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', mode = 'n', desc = 'Put before and indent right' },
    { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', mode = 'n', desc = 'Put before and indent left' },

    { '=p', '<Plug>(YankyPutAfterFilter)', mode = 'n', desc = 'Put after applying a filter' },
    { '=P', '<Plug>(YankyPutBeforeFilter)', mode = 'n', desc = 'Put before applying a filter' },

    -- Yank History Picker (optional, if using snacks/telescope)
    { '<leader>py', '<cmd>YankyRingHistory<cr>', mode = { 'n', 'x' }, desc = 'Open Yank History' },
  },
}
