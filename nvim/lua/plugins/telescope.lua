return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "folke/todo-comments.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
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

        telescope.load_extension("projects")
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

        keymap.set("n", "<leader>fa", "<cmd>Telescope file_browser<cr>", { desc = "Fuzzy file browser" })
        keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Fuzzy find projects" })
        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
        keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Fuzzy find keymaps" })
        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find buffers" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Fuzzy find commands" })
        keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<cr>", { desc = "Fuzzy find treesitter" })
        keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find old files" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>", { desc = "Fuzzy find registers" })
        keymap.set("n", "<leader>fh", "<cmd>Telescope command_history<cr>", { desc = "Fuzzy find command history" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
            { desc = "Find string in current buffer" })
        keymap.set("n", "<leader>fd", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fu", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

        -- LSP
        keymap.set("n", "<leader>fld", "<cmd>Telescope lsp_definitions<cr>", { desc = "Find definitions" })
        keymap.set("n", "<leader>fls", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Find document symbols" })
        keymap.set("n", "<leader>flw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            { desc = "Find dynamic workspace symbols" })
        keymap.set("n", "<leader>flm", "<cmd>Telescope lsp_implementations<cr>", { desc = "Find implementations" })
        keymap.set("n", "<leader>fli", "<cmd>Telescope lsp_incoming_calls<cr>", { desc = "Find incoming calls" })
        keymap.set("n", "<leader>flo", "<cmd>Telescope lsp_outgoing_calls<cr>", { desc = "Find outgoing calls" })
        keymap.set("n", "<leader>flr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references" })
        keymap.set("n", "<leader>flt", "<cmd>Telescope lsp_type_definitions<cr>", { desc = "Find type definitions" })


        -- git
        keymap.set("n", "<leader>fgs", "<cmd>Telescope git_bcommits<cr>", { desc = "Find bcommits" })
        keymap.set("n", "<leader>fgb", "<cmd>Telescope git_branches<cr>", { desc = "Find branches" })
        keymap.set("n", "<leader>fgc", "<cmd>Telescope git_commits<cr>", { desc = "Find commits" })
        keymap.set("n", "<leader>fgf", "<cmd>Telescope git_files<cr>", { desc = "Find files" })
        keymap.set("n", "<leader>fgh", "<cmd>Telescope git_stash<cr>", { desc = "Find stash" })
        keymap.set("n", "<leader>fgs", "<cmd>Telescope git_status<cr>", { desc = "Find status" })

        vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#000000", bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#000000", bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#000000", bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = "#000000", bg = "#000000" })
        --
        -- vim.api.nvim_set_hl(0, "TelescopeMatching", { bg = "#000000" })
        -- -- vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#000000", bg = "#000000" })
        --
        -- -- vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#000000", bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { bg = "#000000" })
        -- -- vim.api.nvim_set_hl(0, "TelescopePromptCounter", { fg = "#000000", bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#000000", bg = "#000000" })
        -- --
        -- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#000000" })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = "#000000", bg = "#000000" })
        -- --
        -- -- vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = "#000000", bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = "#000000", bg = "#000000" })
        -- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000000" })
    end,
}
