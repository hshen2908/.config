return {
    'krady21/compiler-explorer.nvim',
    keys = {
        { "<leader>ac", "<cmd>CECompile<cr>",     desc = "Compile source code" },
        { "<leader>al", "<cmd>CECompileLive<cr>", desc = "Compile source code live" },
        { "<leader>af", "<cmd>CEFormat<cr>",      desc = "Format source code" },
        { "<leader>ae", "<cmd>CEAddLibrary<cr>",  desc = "Add library for future calls" },
        { "<leader>at", "<cmd>CELoadExample<cr>", desc = "Load existing example" },
        { "<leader>aw", "<cmd>CEOpenWebsite<cr>", desc = "Open website" },
        { "<leader>ad", "<cmd>CEDeleteCache<cr>", desc = "Clear cache" },
        { "<leader>ai", "<cmd>CEShowTooltip<cr>", desc = "Show instruction info" },
        { "<leader>ag", "<cmd>CEGotoLabel<cr>",   desc = "Jump to label definition" },
    },
}
