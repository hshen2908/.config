return {
    "luckasRanarison/nvim-devdocs",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        wrap = true,
        mappings = {
            open_in_browser = "<C-b>",
        },
        ensure_installed = {
            "cpp",
            "c",
            "bash",
        }
    },
    keys = {
        { "<leader>rf", "<cmd>DevdocsFetch<CR>",            desc = "Fetch" },
        { "<leader>rt", "<cmd>DevdocsToggle<CR>",           desc = "Toggle" },
        { "<leader>ri", "<cmd>DevdocsInstall<CR>",          desc = "Install" },
        { "<leader>ro", "<cmd>DevdocsOpen<CR>",             desc = "Open" },
        { "<leader>rf", "<cmd>DevdocsOpenFloat<CR>",        desc = "Open Float" },
        { "<leader>rc", "<cmd>DevdocsOpenCurrent<CR>",      desc = "Open Current" },
        { "<leader>rs", "<cmd>DevdocsOpenCurrentFloat<CR>", desc = "Open Current Float" },
        { "<leader>ru", "<cmd>DevdocsUninstall<CR>",        desc = "Uninstall" },
        { "<leader>ra", "<cmd>DevdocsUpdateAll<CR>",        desc = "Update All" },
        { "<leader>ry", "<cmd>DevdocsUpdate<CR>",           desc = "Update" },
    },
}
