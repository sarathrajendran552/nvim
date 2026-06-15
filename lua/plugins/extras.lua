return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "VPavliashvili/json-nvim",
    ft = "json",
    config = function()
      vim.keymap.set("n", "<leader>jff", "<cmd>JsonFormatFile<cr>", { desc = "Format JSON file" })
      vim.keymap.set("n", "<leader>jmf", "<cmd>JsonMinifyFile<cr>", { desc = "Minify JSON file" })
    end,
  },
}
