return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
        handler_opts = {
            border = "none",
        },
        hint_prefix = "  "
    },
    config = function(_, opts)
        local lsp_signature = require("lsp_signature")
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                lsp_signature.on_attach(opts, bufnr)
            end,
        })
    end
}
