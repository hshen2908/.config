return {
    'nvimdev/dashboard-nvim',
    -- event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            shortcut_type = 'number',
            config = {
                header =
                {
                    "                                              ___  ",
                    "                                           ,o88888 ",
                    "                                        ,o8888888' ",
                    "                  ,:o:o:oooo.        ,8O88Pd8888'  ",
                    "              ,.::.::o:ooooOoOoO. ,oO8O8Pd888''    ",
                    "            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O'      ",
                    "           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8'        ",
                    "          , ..:.::o:ooOoOO8O888O8O,COCOO'          ",
                    "         , . ..:.::o:ooOoOOOO8OOOOCOCO'            ",
                    "          . ..:.::o:ooOoOoOO8O8OCCCC'o             ",
                    "             . ..:.::o:ooooOoCoCCC'o:o             ",
                    "             . ..:.::o:o:,cooooCo'oo:o:            ",
                    "          `   . . ..:.:cocoooo''o:o:::'            ",
                    "          .`   . ..::ccccoc''o:o:o:::'             ",
                    "         :.:.    ,c:cccc'':.:.:.:.:.'              ",
                    "       ..:.:''`::::c:''..:.:.:.:.:.'               ",
                    "     ...:.'.:.::::''    . . . . .'                 ",
                    "    .. . ....:.'' `   .  . . ''                    ",
                    "  . . . ....''                                     ",
                    "  .. . .''                                         ",
                    " .                                                 ",
                    "                                                   ",
                    "                                                   ",
                },
                -- header =
                -- {
                --     "                                   ",
                --     "                                   ",
                --     "                                   ",
                --     "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
                --     "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
                --     "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
                --     "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
                --     "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
                --     "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
                --     "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
                --     " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
                --     " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
                --     "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
                --     "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
                --     "                                   ",
                -- },
                shortcut = {
                    {
                        desc = '󰊳 Update',
                        group = '@annotation',
                        action = 'Lazy update',
                        key = 'u'
                    },
                    {
                        -- icon_hl = '@variable',
                        desc = ' Files',
                        group = '@annotation',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        -- desc = ' Apps',
                        desc = ' Projects',
                        group = '@annotation',
                        action = 'Telescope projects',
                        key = 'p',
                    },
                    {
                        desc = '󰁯 Session',
                        group = '@annotation',
                        action = 'SessionRestore',
                        key = 'r',
                    },
                    {
                        desc = ' dotfiles',
                        group = '@annotation',
                        action = 'edit ~/.config/nvim',
                        key = 'd',
                    },
                },
                footer = {},
            }
        }
        vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#FFFFFF", bg = "#000000" })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
