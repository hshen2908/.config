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
            { "<leader>y", group = "Yazi" },
            { "<leader>u", group = "Utilities" },
            { "<leader>d", group = "Debugger" },
            { "<leader>e", group = "Explorer" },
            { "<leader>g", group = "Git" },
            { "<leader>l", group = "LSP" },
            { "<leader>t", group = "Tabs" },
            { "<leader>s", group = "Splits" },
            { "<leader>w", group = "Sessions" },
            { "<leader>x", group = "Trouble" },
        })
    end
}
