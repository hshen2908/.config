return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim"
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_dap = require("mason-nvim-dap")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "tinymist",
                "pylsp",
                "lua_ls",
                "clangd",
                "texlab",
                "elp",
                "biome",
                "html",
                "emmet_ls",
                "cssls",
                "sqlls",
                "ts_ls",
            },
        })

        mason_dap.setup({
            ensure_installed = {
                "cpptools",
                "codelldb",
                "erlang-debugger",
            },
            automatic_installation = true,
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                -- "stylua", -- lua formatter
                "isort",    -- python formatter
                "black",    -- python formatter
                "pylint",
                -- "eslint_d",
            },
        })
    end,
}
