return {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
        local dropbarapi = require("dropbar.api")
        local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { desc = desc })
        end

        map("n", "<leader>b", dropbarapi.pick, "Pick Dropbar")
    end
}
