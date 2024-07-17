return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local transform_mod = require("telescope.actions.mt").transform_mod

        local trouble = require("trouble")
        local trouble_sources_telescope = require("trouble.sources.telescope")
        local trouble_telescope = require("trouble.providers.telescope")

        -- or create your custom action
        local custom_actions = transform_mod({
            open_trouble_qflist = function(prompt_bufnr)
                trouble.toggle("quickfix")
            end,
        })

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-t>"] = trouble_sources_telescope.open,
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local keymap = vim.keymap -- for conciseness

        keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", { desc = "Fuzzy find keymaps" })
        keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })
        keymap.set("n", "<leader>tc", "<cmd>Telescope commands<cr>", { desc = "Fuzzy find commands" })
        keymap.set("n", "<leader>tt", "<cmd>Telescope treesitter<cr>", { desc = "Fuzzy find treesitter" })
        keymap.set("n", "<leader>to", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find old files" })
        keymap.set("n", "<leader>tr", "<cmd>Telescope registers<cr>", { desc = "Fuzzy find registers" })
        keymap.set("n", "<leader>th", "<cmd>Telescope command_history<cr>", { desc = "Fuzzy find command history" })
        keymap.set("n", "<leader>ts", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            { desc = "Find string in current buffer" })
        keymap.set("n", "<leader>td", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>tu", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })

        -- LSP
        keymap.set("n", "<leader>tld", "<cmd>Telescope lsp_definitions<cr>", { desc = "Find definitions" })
        keymap.set("n", "<leader>tls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find document symbols" })
        keymap.set("n", "<leader>tlw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            { desc = "Find dynamic workspace symbols" })
        keymap.set("n", "<leader>tlm", "<cmd>Telescope lsp_implementations<cr>", { desc = "Find implementations" })
        keymap.set("n", "<leader>tli", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Find incoming calls" })
        keymap.set("n", "<leader>tlo", "<cmd>Telescope lsp_outgoing_calls<cr>", { desc = "Find outgoing calls" })
        keymap.set("n", "<leader>tlr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references" })
        keymap.set("n", "<leader>tlt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Find type definitions" })


        -- git
        keymap.set("n", "<leader>tgs", "<cmd>Telescope git_bcommits<cr>", { desc = "Find bcommits" })
        keymap.set("n", "<leader>tgb", "<cmd>Telescope git_branches<cr>", { desc = "Find branches" })
        keymap.set("n", "<leader>tgc", "<cmd>Telescope git_commits<cr>", { desc = "Find commits" })
        keymap.set("n", "<leader>tgf", "<cmd>Telescope git_files<cr>", { desc = "Find files" })
        keymap.set("n", "<leader>tgh", "<cmd>Telescope git_stash<cr>", { desc = "Find stash" })
        keymap.set("n", "<leader>tgs", "<cmd>Telescope git_status<cr>", { desc = "Find status" })
    end,
}
