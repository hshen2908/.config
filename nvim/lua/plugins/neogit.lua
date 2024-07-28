return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        -- "ibhagwan/fzf-lua",          -- optional
    },
    config = true,
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>",               desc = "Neogit" },
        { "<leader>gq", "<cmd>Neogit bisect<cr>",        desc = "Bisect" },
        { "<leader>gb", "<cmd>Neogit branch<cr>",        desc = "Branch" },
        { "<leader>gy", "<cmd>Neogit branch_config<cr>", desc = "Branch Config" },
        { "<leader>gp", "<cmd>Neogit cherry_pick<cr>",   desc = "Cherry Pick" },
        { "<leader>gc", "<cmd>Neogit commit<cr>",        desc = "Commit" },
        { "<leader>ga", "<cmd>Neogit diff<cr>",          desc = "Diff" },
        { "<leader>gf", "<cmd>Neogit fetch<cr>",         desc = "Fetch" },
        { "<leader>gi", "<cmd>Neogit ignore<cr>",        desc = "Ignore" },
        { "<leader>gl", "<cmd>Neogit log<cr>",           desc = "Log" },
        { "<leader>gm", "<cmd>Neogit merge<cr>",         desc = "Merge" },
        { "<leader>gu", "<cmd>Neogit pull<cr>",          desc = "Pull" },
        { "<leader>gp", "<cmd>Neogit push<cr>",          desc = "Push" },
        { "<leader>ge", "<cmd>Neogit rebase<cr>",        desc = "Rebase" },
        { "<leader>gr", "<cmd>Neogit remote<cr>",        desc = "Remote" },
        { "<leader>gn", "<cmd>Neogit remote_config<cr>", desc = "Remote Config" },
        { "<leader>gx", "<cmd>Neogit reset<cr>",         desc = "Reset" },
        { "<leader>go", "<cmd>Neogit revert<cr>",        desc = "Revert" },
        { "<leader>gs", "<cmd>Neogit stash<cr>",         desc = "Stash" },
        { "<leader>gt", "<cmd>Neogit tag<cr>",           desc = "Tag" },
        { "<leader>gw", "<cmd>Neogit worktree<cr>",      desc = "Worktree" },
    },
}
