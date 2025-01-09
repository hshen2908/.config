return {
    {
        "kevinhwang91/nvim-ufo",
        event = "BufEnter",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        config = function()
            --- @diagnostic disable: unused-local
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end

            -- buffer scope handler
            -- will override global handler if it is existed
            -- local bufnr = vim.api.nvim_get_current_buf()
            -- require('ufo').setFoldVirtTextHandler(bufnr, handler)
            ---vim.o.foldcolumn = '1' -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            local ftMap = {
                vim = 'indent',
                python = { 'indent' },
                git = ''
            }
            require('ufo').setup({
                fold_virt_text_handler = handler,
                open_fold_hl_timeout = 150,
                close_fold_kinds_for_ft = {
                    default = { 'imports', 'comment' },
                    json = { 'array' },
                    c = { 'comment' }
                },
                preview = {
                    win_config = {
                        border = { '', '─', '', '', '', '─', '', '' },
                        winhighlight = 'Normal:Folded',
                        winblend = 0
                    },
                    mappings = {
                        scrollU = '<C-u>',
                        scrollD = '<C-d>',
                        jumpTop = '[',
                        jumpBot = ']'
                    }
                },
                provider_selector = function(bufnr, filetype, buftype)
                    -- if you prefer treesitter provider rather than lsp,
                    -- return ftMap[filetype] or {'treesitter', 'indent'}
                    return ftMap[filetype]

                    -- refer to ./doc/example.lua for detail
                end
            })
            vim.keymap.set('n', '<leader>oo', require('ufo').openAllFolds, { desc = 'Open All Folds' })
            vim.keymap.set('n', '<leader>oc', require('ufo').closeAllFolds, { desc = 'Close All Folds' })
            vim.keymap.set('n', '<leader>oe', require('ufo').openFoldsExceptKinds, { desc = 'Open Folds Except Kinds' })
            vim.keymap.set('n', '<leader>ow', require('ufo').closeFoldsWith, { desc = 'Close Folds With' }) -- closeAllFolds == closeFoldsWith(0)
            vim.keymap.set('n', '<leader>ot', "za", { desc = 'Toggle Fold Under Cursor' })                  -- closeAllFolds == closeFoldsWith(0)
            vim.keymap.set('n', '<leader>oa', "zA", { desc = 'Toggle All Fold Under Cursor' })              -- closeAllFolds == closeFoldsWith(0)
            vim.keymap.set('n', '<leader>oi', function()
                local winid = require('ufo').peekFoldedLinesUnderCursor()
                if not winid then
                    -- choose one of coc.nvim and nvim lsp
                    vim.fn.CocActionAsync('definitionHover') -- coc.nvim
                    vim.lsp.buf.hover()
                end
            end, { desc = 'Peek Fold' })
            require("ufo").setup({
                provider_selector = function(_bufnr, _filetype, _buftype)
                    return { "treesitter", "indent" }
                end,
            })
        end,
    },
}
