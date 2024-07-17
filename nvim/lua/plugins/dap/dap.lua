return {
    "mfussenegger/nvim-dap",
    config = function()
        local dap = require("dap")
        vim.fn.sign_define('DapBreakpoint', { text = '󰃤' })
        dap.configurations = {
            c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }
        }

        dap.adapters = {
            gdb = {
                type = "executable",
                command = "gdb",
                args = { "-i", "dap" }
            }
        }
    end
}
