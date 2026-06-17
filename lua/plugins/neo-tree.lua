return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<C-n>", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_hidden = false,
      },
    },
  },
}
