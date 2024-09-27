return {
	"VPavliashvili/json-nvim",
	ft = "json",
	config = function()
		vim.keymap.set("n", "<leader>jff", "<cmd>JsonFormatFile<cr>", { desc = "JsonFormatFile"} )
		vim.keymap.set("n", "<leader>jmf", "<cmd>JsonMinifyFile<cr>", { desc = "JsonMinifyFile"} )
		vim.keymap.set("n", "<leader>jmt", "<cmd>JsonMinifyToken<cr>", { desc = "JsonMinifyToken"} )
		vim.keymap.set("n", "<leader>jft", "<cmd>JsonFormatToken<cr>", { desc = "JsonFormatToken"} )
    end,
}
