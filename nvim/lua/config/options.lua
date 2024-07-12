vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true

-- tabs and indentation
opt.tabstop = 4       -- spaces for tabs
opt.shiftwidth = 4    -- spaces for indent
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one

-- search setting
opt.ignorecase = true
opt.smartcase = true -- mixed case assumes case-sensitive

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clupboard as default register

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.swapfile = false
