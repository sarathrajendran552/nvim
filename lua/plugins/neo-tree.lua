return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = ":Neotree Toggle" })
        require("neo-tree").setup({
            close_if_last_window = true,
            filesystem = {
                hide_dotfiles = false,
                hide_hidden = false
            }
        })
    end
}
