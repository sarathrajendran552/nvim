return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSUpdate" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "lua", "vim", "vimdoc", "query",
        "python", "go", "bash", "json", "yaml",
        "javascript", "html", "css", "markdown",
      },
      auto_install = false,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
