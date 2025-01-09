return {
    'RaafatTurki/hex.nvim',
    opts = {},
    config = function(_, opts)
        local hex = require("hex")
        hex.setup(opts)
    end,
    keys = {
        { "<leader>hd", "<cmd>HexDump<cr>",     desc = "Switch to hex view" },
        { "<leader>ha", "<cmd>HexAssemble<cr>", desc = "Switch to normal view" },
        { "<leader>ht", "<cmd>HexToggle<cr>",   desc = "Toggle hex" },
    },
}
