return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    opts = {
        adapters = {
        },
    },
    config = function(_, opts)
        local neotest = require("neotest")
        neotest.setup(opts)

        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { desc = desc })
        end

        map("n", "<leader>tr", neotest.run.run, "Run nearest test")
        map("n", "<leader>ts", neotest.run.stop, "Stop nearest test")
        map("n", "<leader>ta", neotest.run.attach, "Attach nearest test")
        map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, "Run current file")
        map("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, "Debug nearest test")
        map("n", "<leader>to", neotest.output_panel.toggle, "Toggle output panel")
        map("n", "<leader>ts", neotest.summary.toggle, "Toggle summary window")
    end
}
