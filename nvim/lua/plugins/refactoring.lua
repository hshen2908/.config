return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
        require("refactoring").setup()
        vim.keymap.set("x", "<leader>je", ":Refactor extract ", { desc = "Extract" })
        vim.keymap.set("x", "<leader>jf", ":Refactor extract_to_file ", { desc = "Extract to file" })

        vim.keymap.set("x", "<leader>jv", ":Refactor extract_var ", { desc = "Extract var" })

        vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var", { desc = "Inline var" })

        vim.keymap.set("n", "<leader>jI", ":Refactor inline_func", { desc = "Inline func" })

        vim.keymap.set("n", "<leader>jb", ":Refactor extract_block", { desc = "Extract block" })
        vim.keymap.set("n", "<leader>jbf", ":Refactor extract_block_to_file", { desc = "Extract block to file" })
        -- prompt for a refactor to apply when the remap is triggered
        vim.keymap.set(
            { "n", "x" },
            "<leader>jr",
            function() require('refactoring').select_refactor() end
            , { desc = "Select refactor" })
        -- Note that not all refactor support both normal and visual mode
        -- You can also use below = true here to to change the position of the printf
        -- statement (or set two remaps for either one). This remap must be made in normal mode.
        vim.keymap.set(
            "n",
            "<leader>jp",
            function() require('refactoring').debug.printf({ below = false }) end
            , { desc = "Print var" })

        -- Print var

        vim.keymap.set({ "x", "n" }, "<leader>jv", function() require('refactoring').debug.print_var() end,
            { desc = "Debug print" })
        -- Supports both visual and normal mode

        vim.keymap.set("n", "<leader>jc", function() require('refactoring').debug.cleanup({}) end,
            { desc = "Debug print var" })
        -- Supports only normal mode
    end,
}
