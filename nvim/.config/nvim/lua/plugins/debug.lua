-- Debug Adapter Protocol (DAP) integration for Neovim
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Required dependency for nvim-dap-ui
    { 'nvim-neotest/nvim-nio' },
    
    -- Creates a beautiful debugger UI
    { 'rcarriga/nvim-dap-ui', dependencies = { 'nvim-neotest/nvim-nio' } },
    
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    
    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    
    -- Set up UI
    dapui.setup()
    
    -- Auto open and close dapui
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
    
    -- Set up keymaps for debugging
    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = 'Debug: [T]oggle Breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: [C]ontinue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step [O]ver' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step [O]ut' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Debug: Toggle [R]EPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run [L]ast' })
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle [U]I' })
    vim.keymap.set('n', '<leader>dx', function() 
      dap.terminate()
      dapui.close()
    end, { desc = 'Debug: Terminate/E[x]it' })
    
    -- Install debug adapters automatically
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      ensure_installed = {
        -- Add the languages you use
      },
    }
  end,
}