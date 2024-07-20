return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    config = function()
        local whichkey = require("which-key")
        whichkey.add({
            { "<leader>f", group = "Find" },
            { "<leader>y", group = "Yazi", icon = { icon = "󰇥", color = "yellow" } },
            { "<leader>u", group = "Utilities", icon = { icon = "", color = "orange" } },
            { "<leader>d", group = "Debugger" },
            { "<leader>e", group = "Explorer", icon = { icon = "󰙅", color = "green" } },
            { "<leader>g", group = "Git" },
            { "<leader>l", group = "LSP", icon = { icon = "", color = "blue" } },
            { "<leader>b", group = "Tabs" },
            { "<leader>t", group = "Test", icon = { icon = "󰙨", color = "purple" } },
            { "<leader>s", group = "Splits", icon = { icon = "", color = "orange" } },
            { "<leader>w", group = "Sessions" },
            { "<leader>x", group = "Trouble", icon = { icon = "", color = "yellow" } },
        })
    end
}
