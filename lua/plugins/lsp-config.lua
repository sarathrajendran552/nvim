return {
  {
      "williamboman/mason.nvim",
      config = function()
          require("mason").setup()
      end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls", "tsserver", "snyk_ls", "pylsp", "clangd" }
        })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.clangd.setup({})
      vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, { desc = "Description under cursor" })
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Definition" })
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Actions" })
    end
  }
}
