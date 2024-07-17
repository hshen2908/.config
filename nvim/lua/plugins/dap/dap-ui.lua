return {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
        local dap, dapui = require("dap"), require("dapui")
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

        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { desc = desc })
        end

        map("n", "<leader>dt", dapui.toggle, "Toggle Debug UI")
        -- Start debugging session
        map("n", "<leader>ds", function()
            dap.continue()
            dapui.toggle({})
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
        end, "Start Debug Session")

        -- Set breakpoints, get variable values, step into/out of functions, etc.
        map("n", "<leader>dl", require("dap.ui.widgets").hover, "Dapui hover")
        map("n", "<leader>dc", dap.continue, "Continue")
        map("n", "<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint")
        map("n", "<leader>dn", dap.step_over, "Step Over")
        map("n", "<leader>di", dap.step_into, "Setp Into")
        map("n", "<leader>do", dap.step_out, "Step Out")
        map("n", "<leader>dx", function()
            dap.clear_breakpoints()
        end, "Clear Breackpoints")

        -- Close debugger and clear breakpoints
        map("n", "<leader>de", function()
            dap.clear_breakpoints()
            dapui.toggle({})
            dap.terminate()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
        end, "Close Debugger")
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸" },
            mappings = {
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            layouts = {
                {
                    elements = {
                        "scopes",
                        "stacks",
                        "watches"
                    },
                    size = 0.3,
                    position = "right"
                },
                {
                    elements = {
                        "repl",
                        "breakpoints",
                        "console",
                    },
                    size = 0.3,
                    position = "bottom",
                },
            },
            floating = {
                max_height = nil,
                max_width = nil,
                border = "single",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil,
            },
        })
    end
}
