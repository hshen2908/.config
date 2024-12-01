return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")

        -- import mason_lspconfig plugin
        local mason_lspconfig = require("mason-lspconfig")

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "<leader>le", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>lc", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>lb", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Toggle line diagnostics"
                keymap.set("n", "<leader>lt", function()
                    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                end, opts) -- show diagnostics for line

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>ll", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "<leader>lh", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>ls", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        -- Change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end


        mason_lspconfig.setup_handlers({
            -- default handler for installed servers
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,
            ["tinymist"] = function()
                lspconfig["tinymist"].setup({
                    capabilities = capabilities,
                    single_file_support = true,
                    root_dir = function()
                        return vim.fn.getcwd()
                    end,
                    on_attach = function()
                        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                            pattern = "*.typ",
                            callback = function()
                                local buf = vim.api.nvim_get_current_buf()
                                vim.api.nvim_set_option_value("filetype", "typst", { buf = buf })
                            end,
                        })
                    end,
                    --- See [Tinymist Server Configuration](https://github.com/Myriad-Dreamin/tinymist/blob/main/Configuration.md) for references.
                    settings = {
                        exportPdf = "onType",
                    },
                })
            end,
            -- ["svelte"] = function()
            --     -- configure svelte server
            --     lspconfig["svelte"].setup({
            --         capabilities = capabilities,
            --         on_attach = function(client, bufnr)
            --             vim.api.nvim_create_autocmd("BufWritePost", {
            --                 pattern = { "*.js", "*.ts" },
            --                 callback = function(ctx)
            --                     -- Here use ctx.match instead of ctx.file
            --                     client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            --                 end,
            --             })
            --         end,
            --     })
            -- end,
            ["biome"] = function()
                -- configure graphql language server
                lspconfig["html"].setup({
                    capabilities = capabilities,
                    cmd = { "vscode-html-language-server", "--stdio" },
                    filetypes = { "html", "templ" },
                    single_file_support = false,
                    init_options = {
                        configurationSection = { "html", "css", "javascript" },
                        embeddedLanguages = {
                            css = true,
                            javascript = true
                        },
                        provideFormatter = true
                    },
                    root_dir = lspconfig.util.root_pattern('.git'),
                    on_attach = function()
                        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                            pattern = "*.html",
                            callback = function()
                                local buf = vim.api.nvim_get_current_buf()
                                vim.api.nvim_set_option_value("filetype", "html", { buf = buf })
                            end,
                        })
                    end,
                })
            end,
            ["biome"] = function()
                -- configure graphql language server
                lspconfig["biome"].setup({
                    capabilities = capabilities,
                    cmd = { "biome", "lsp-proxy" },
                    filetypes = { "astro", "css", "graphql", "javascript", "javascriptreact", "json", "jsonc", "svelte", "typescript", "typescript.tsx", "typescriptreact", "vue" },
                    single_file_support = false,
                    root_dir = lspconfig.util.root_pattern('.git'),
                    on_attach = function()
                        vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                            pattern = "*.js",
                            callback = function()
                                local buf = vim.api.nvim_get_current_buf()
                                vim.api.nvim_set_option_value("filetype", "javascript", { buf = buf })
                            end,
                        })
                    end,
                })
            end,
            ["sqls"] = function()
                -- configure graphql language server
                lspconfig["sqls"].setup({
                    capabilities = capabilities,
                    cmd = { "sqls" },
                    root_dir = lspconfig.util.root_pattern('.git'),
                    filetypes = { "sql", "mysql" },
                })
            end,
            ["sqlls"] = function()
                -- configure graphql language server
                lspconfig["sqlls"].setup({
                    capabilities = capabilities,
                    cmd = { "sql-language-server", "up", "--method", "stdio" },
                    root_dir = lspconfig.util.root_pattern('.git'),
                    filetypes = { "sql", "mysql" },
                })
            end,
            ["emmet_ls"] = function()
                -- configure emmet language server
                lspconfig["emmet_ls"].setup({
                    capabilities = capabilities,
                    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
                })
            end,
            ["lua_ls"] = function()
                -- configure lua server (with special settings)
                lspconfig["lua_ls"].setup({
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            -- make the language server recognize "vim" global
                            diagnostics = {
                                globals = { "vim" },
                            },
                            completion = {
                                callSnippet = "Replace",
                            },
                        },
                    },
                })
            end,
        })
    end,
}
