return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    version = "*",
    opts = {
        options = {
            mode = "tabs",
            diagnostics = "nvim_lsp",
            buffer_close_icon = "",
            always_show_bufferline = true,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = ""
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " "
                        or (e == "warning" and " " or " ")
                    s = s .. n .. sym
                end
                return s
            end
        },
    },
    keys = { { "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Bufferline Pick" } },
}
