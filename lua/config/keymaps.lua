local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Close buffer" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
