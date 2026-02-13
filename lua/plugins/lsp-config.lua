return {
  -- Mason
  {
    "williamboman/mason.nvim",
    opts = {},
  },

  -- Mason-LSPConfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "pylsp", "clangd", "jsonls", "gopls" },
      automatic_installation = false, -- optional
    },
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true })
      end

      -- Setup servers
      for _, server in ipairs({ "lua_ls", "clangd", "pylsp", "jsonls", "gopls" }) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end
    end,
  },
}
