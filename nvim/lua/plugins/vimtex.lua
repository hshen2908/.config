return {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
        vim.cmd([[" This is necessary for VimTeX to load properly. The "indent" is optional.
                " Note: Most plugin managers will do this automatically!
                filetype plugin indent on

                " This enables Vim's and neovim's syntax-related features. Without this, some
                " VimTeX features will not work (see ":help vimtex-requirements" for more
                " info).
                " Note: Most plugin managers will do this automatically!
                syntax enable

                " Viewer options: One may configure the viewer either by specifying a built-in
                " viewer method:
                let g:vimtex_view_method = 'zathura'
                let g:vimtex_quickfix_autoclose_after_keystrokes = 1

                " Or with a generic interface:
                let g:vimtex_view_general_viewer = 'okular'
                let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

                " VimTeX uses latexmk as the default compiler backend. If you use it, which is
                " strongly recommended, you probably don't need to configure anything. If you
                " want another compiler backend, you can change it as follows. The list of
                " supported backends and further explanation is provided in the documentation,
                " see ":help vimtex-compiler".
                " let g:vimtex_compiler_method = 'latexrun'
                let g:vimtex_compiler_latexmk = {
                    \ 'options' : [
                    \    '-shell-escape',
                    \    '-verbose',
                    \    '-file-line-error',
                    \    '-synctex=1',
                    \    '-interaction=nonstopmode',
                    \ ],
                    \}

                " Most VimTeX mappings rely on localleader and this can be changed with the
                " following line. The default is usually fine and is the symbol "\".
                " let maplocalleader = ","
                 nmap <leader>vi <plug>(vimtex-info)
                 nmap <leader>vI <plug>(vimtex-info-full)
                 nmap <leader>vt <plug>(vimtex-toc-open)
                 nmap <leader>vT <plug>(vimtex-toc-toggle)
                 nmap <leader>vy <plug>(vimtex-labels-open)
                 nmap <leader>vY <plug>(vimtex-labels-toggle)
                 nmap <leader>vv <plug>(vimtex-view)
                 nmap <leader>vr <plug>(vimtex-reverse-search)
                 nmap <leader>vl <plug>(vimtex-compile)
                 nmap <leader>vk <plug>(vimtex-stop)
                 nmap <leader>vK <plug>(vimtex-stop-all)
                 nmap <leader>ve <plug>(vimtex-errors)
                 nmap <leader>vo <plug>(vimtex-compile-output)
                 nmap <leader>vg <plug>(vimtex-status)
                 nmap <leader>vG <plug>(vimtex-status-all)
                 nmap <leader>vc <plug>(vimtex-clean)
                 nmap <leader>vC <plug>(vimtex-clean-full)
                 nmap <leader>vm <plug>(vimtex-imaps-list)
                 nmap <leader>vx <plug>(vimtex-reload)
                 nmap <leader>vs <plug>(vimtex-toggle-main)
]])
        -- VimTeX configuration goes here, e.g.
        -- vim.g.vimtex_view_method = "zathura"
    end
}
