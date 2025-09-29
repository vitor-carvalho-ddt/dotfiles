-- Debug Adapter Protocol (DAP) integration for Neovim
return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    -- nvim-dap-ui depends on nvim-dap
    'https://github.com/nvim-neotest/nvim-nio',
    'rcarriga/nvim-dap-ui',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local utils = require 'dap.utils'

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

    -- typescript
    dap.adapters['pwa-node'] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'node',
        args = { os.getenv 'HOME' .. '/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js', '${port}' },
      },
    }

    -- Attach to Nest (start:debug)
    local attach_server = {
      type = 'pwa-node',
      request = 'attach',
      name = 'Attach Nest (9229)',
      port = 9229,
      cwd = '${workspaceFolder}',
      sourceMaps = true,
      resolveSourceMapLocations = { '${workspaceFolder}/**', '!**/node_modules/**' },
      -- skipFiles = { '<node_internals>/**' },
      autoAttachChildProcesses = true, -- survives Nest watch restarts
      restart = true, -- reconnect on restart
      attachTimeoutMs = 10000,
      console = 'integratedTerminal',
    }

    local attach_jest = vim.deepcopy(attach_server)
    attach_jest.name = 'Attach Jest (9229)'

    dap.configurations.typescript = { attach_server, attach_jest }
    dap.configurations.javascript = dap.configurations.typescript

    local function VKSN(map, func, description)
      vim.keymap.set('n', map, func, { desc = description })
    end

    VKSN('<leader>ll', function()
      vim.cmd 'w'
      vim.cmd 'so'
    end, 'save file and sources to vim')

    -- DEBUGGER KEYMAPS
    VKSN('l', function()
      dap.step_into()
    end, 'Step Into')
    VKSN('L', function()
      dap.step_out()
    end, 'Step Out')
    VKSN('k', function()
      dap.step_over()
    end, 'Step Over')

    -- Set up keymaps for debugging
    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = 'Debug: [T]oggle Breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: [C]ontinue' })
    -- vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step [I]nto' })
    -- vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step [O]ver' })
    vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step [O]ut' })
    vim.keymap.set('n', '<leader>dr', dap.repl.toggle, { desc = 'Debug: Toggle [R]EPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Debug: Run [L]ast' })
    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle [U]I' })
    vim.keymap.set('n', '<leader>dx', function()
      dap.terminate()
      dapui.close()
    end, { desc = 'Debug: Terminate/E[x]it' })
  end,
}
