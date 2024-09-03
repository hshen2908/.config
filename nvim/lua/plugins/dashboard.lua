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
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon_hl = '@variable',
                        desc = ' Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        -- desc = ' Apps',
                        desc = ' Projects',
                        group = "String",
                        action = 'Telescope projects',
                        key = 'p',
                    },
                    {
                        desc = '󰁯 Session',
                        icon_hl = "@function",
                        action = 'SessionRestore',
                        key = 'r',
                    },
                    {
                        desc = ' dotfiles',
                        group = 'Number',
                        action = 'edit ~/.config/nvim',
                        key = 'd',
                    },
                },
                footer = {},
            }
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
