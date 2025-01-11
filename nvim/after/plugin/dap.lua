local dap, dapui = require("dap"), require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Configure nvim-dap-python with the path to the debugpy executable
require('dap-python').setup('python3')  -- Adjust path if needed


-- You can map keys to start debugging or step through code
vim.api.nvim_set_keymap('n', '<F5>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ui', ':lua require"dapui".toggle()<CR>', { noremap = true, silent = true })

table.insert(require('dap').configurations.python, {
    {
        justMyCode = false, -- <--- insert here
        type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = 'launch file',
        -- 此处指向当前文件
        program = '${file}',
        args = function()
            local user_input = vim.fn.input('Enter arguments: ')  -- Prompt for input
            return vim.split(user_input, ' ')  -- Split input into a table of arguments
        end,
        pythonPath = function()
            local venv_path = os.getenv("CONDA_PREFIX")
            if venv_path then
                return venv_path .. "/bin/python"
            end
            return "/usr/bin/python3"
        end
    },
})

dap.adapters.c = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/kali/.vscode/extensions/ms-vscode.cpptools-1.22.11-linux-x64/debugAdapters/bin/OpenDebugAD7',
}

local dap = require('dap')
dap.configurations.c = {
    {
        name = "Launch file",
        type = "c",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = function()
            local user_input = vim.fn.input('Enter arguments: ')  -- Prompt for input
            return vim.split(user_input, ' ')  -- Split input into a table of arguments
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
    },
}
dap.configurations.cpp = dap.configurations.c
