return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>gf", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end

    local servers = {
      pyright = {},
      ruff = {},
      bashls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      },
      gopls = {},
      ts_ls = {},
    }

    for server, opts in pairs(servers) do
      local config = lspconfig[server].document_config
      local cmd = config and config.default_config and config.default_config.cmd
      if cmd and type(cmd) == "table" and vim.fn.executable(cmd[1]) == 1 then
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, opts))
      end
    end
  end,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
}
