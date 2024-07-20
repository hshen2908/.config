return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    version = "*",
    opts = {
        options = {
            mode = "tabs",
            diagnostics = "nvim_lsp",
            always_show_bufferline = true
        },
    },
    keys = { { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Bufferline Pick" } },
}
