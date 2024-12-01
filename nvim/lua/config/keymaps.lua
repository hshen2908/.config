vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>uh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>un", ":set relativenumber!<CR>", { desc = "Toggle relative line numbers" })

-- increment/decrement numbers
keymap.set("n", "<leader>u+", "<C-a>", { desc = "Increment number" })                     -- increment
keymap.set("n", "<leader>u-", "<C-x>", { desc = "Decrement number" })                     -- decrement
keymap.set("n", "<leader>ut", "<cmd>windo set scrollbind!<cr>", { desc = "Scroll Bind" }) -- decrement
keymap.set("n", "<leader>ul", "<cmd>Lazy<CR>", { desc = "Open Lazy" })
keymap.set("n", "<leader>uc", "<cmd>edit ~/.config/nvim<cr>", { desc = "Configure NVIM" })
keymap.set("n", "<leader>up", function() vim.ui.open("main.pdf") end, { desc = "Open main.pdf" })
keymap.set("n", "<leader>ux", function() vim.cmd("windo diffthis") end, { desc = "Diff Splits" })
keymap.set("n", "<leader>uz", function() vim.cmd("windo diffoff") end, { desc = "Diff Off" })
keymap.set("n", "<leader>us", "z=", { desc = "Spelling Suggestions" })
keymap.set("n", "<leader>um", "zz", { desc = "Center Line" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sq", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<C-k>", ":wincmd k<CR>", { desc = "Move to split above" })
keymap.set("n", "<C-j>", ":wincmd j<CR>", { desc = "Move to split below" })
keymap.set("n", "<C-h>", ":wincmd h<CR>", { desc = "Move to split to the left" })
keymap.set("n", "<C-l>", ":wincmd l<CR>", { desc = "Move to split to the right" })

keymap.set("n", "<leader>bo", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>bq", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>bn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>bp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>bf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
