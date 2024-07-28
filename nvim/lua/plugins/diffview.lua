return {
    "sindrets/diffview.nvim",
    opts = {},
    keys = {
        { "<leader>gdo", "<cmd>DiffviewOpen<cr>",          desc = "Open diff view" },
        { "<leader>gdq", "<cmd>DiffviewClose<cr>",         desc = "Close diff view" },
        { "<leader>gdh", "<cmd>DiffviewFileHistory<cr>",   desc = "Open path history" },
        { "<leader>gdf", "<cmd>DiffviewFileHistory %<cr>", desc = "Open file history" },
    },
}
