return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {},
    config = function(_, opts)
        local toggleterm = require("toggleterm")
        toggleterm.setup(opts)

        function _G.set_terminal_keymaps()
            local o = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], o)
            -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], o)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], o)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], o)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], o)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], o)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], o)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
    keys = {
        { "<leader>cc", "<cmd>ToggleTerm<cr>",          desc = "Create new terminal" },
        { "<leader>ca", "<cmd>ToggleTermToggleAll<cr>", desc = "Toggle all terminals" },
        { "<leader>cs", "<cmd>TermSelect<cr>",          desc = "Select terminals" },
    },
}
