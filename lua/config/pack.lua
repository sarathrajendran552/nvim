vim.pack.add({
  {
    src = "https://github.com/catppuccin/nvim",
    name = "catppuccin",
  },
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
  "https://github.com/VPavliashvili/json-nvim",
})

local pack_opt = vim.fn.stdpath("data") .. "/site/pack/core/opt"
if vim.fn.isdirectory(pack_opt .. "/catppuccin") ~= 1 then
  vim.pack.update(nil, { force = true })
  vim.cmd("packloadall")
end

vim.cmd("packadd catppuccin")
vim.cmd.colorscheme("catppuccin")

vim.api.nvim_create_autocmd("UIEnter", {
  callback = function()
    vim.cmd("packadd catppuccin")
    vim.cmd("packadd nvim-web-devicons")
    vim.cmd("packadd lualine.nvim")
    require("lualine").setup({
      options = {
        theme = "catppuccin-mocha",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    })

    vim.cmd("packadd which-key.nvim")
    local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>g", group = "Grep" },
    })
    vim.keymap.set("n", "<leader>?", function()
      wk.show({ global = false })
    end, { desc = "Show local keymaps" })
  end,
  once = true,
})

local telescope_loaded = false
local function load_telescope()
  if telescope_loaded then return end
  telescope_loaded = true
  vim.cmd("packadd plenary.nvim")
  vim.cmd("packadd telescope.nvim")
  vim.cmd("packadd telescope-ui-select.nvim")
  require("telescope").setup({
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = { hidden = true },
    },
    extensions = {
      ["ui-select"] = require("telescope.themes").get_dropdown({}),
    },
  })
  require("telescope").load_extension("ui-select")
end

for _, k in ipairs({
  { "<leader>ff", "find_files", "Find files" },
  { "<leader>fg", "live_grep", "Live grep" },
  { "<leader>fb", "buffers", "Buffers" },
  { "<leader>fh", "help_tags", "Help tags" },
  { "<leader>fs", "lsp_document_symbols", "LSP symbols" },
  { "<leader>fr", "oldfiles", "Recent files" },
}) do
  vim.keymap.set("n", k[1], function()
    load_telescope()
    require("telescope.builtin")[k[2]]()
  end, { desc = k[3] })
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  callback = function()
    vim.cmd("packadd nvim-treesitter")
    require("nvim-treesitter").setup({
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
  once = true,
})

local neo_tree_loaded = false
vim.keymap.set("n", "<C-n>", function()
  if not neo_tree_loaded then
    neo_tree_loaded = true
    vim.cmd("packadd nui.nvim")
    vim.cmd("packadd nvim-web-devicons")
    vim.cmd("packadd plenary.nvim")
    vim.cmd("packadd neo-tree.nvim")
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_hidden = false,
        },
      },
    })
  end
  vim.cmd("Neotree toggle")
end, { desc = "Toggle file tree" })

local render_md_loaded = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    if not render_md_loaded then
      render_md_loaded = true
      vim.cmd("packadd nvim-web-devicons")
      vim.cmd("packadd render-markdown.nvim")
      require("render-markdown").setup({})
    end
  end,
})

local json_nvim_loaded = false
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    if not json_nvim_loaded then
      json_nvim_loaded = true
      vim.cmd("packadd json-nvim")
    end
  end,
})
vim.keymap.set("n", "<leader>jff", "<cmd>JsonFormatFile<cr>", { desc = "Format JSON file" })
vim.keymap.set("n", "<leader>jmf", "<cmd>JsonMinifyFile<cr>", { desc = "Minify JSON file" })

local function lsp_on_attach(client, bufnr)
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

if vim.fn.executable("lua-language-server") == 1 then
  vim.lsp.config['lua_ls'] = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
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
    on_attach = lsp_on_attach,
  }
  vim.lsp.enable("lua_ls")
end

if vim.fn.executable("pyright") == 1 or vim.fn.executable("pyright-langserver") == 1 then
  vim.lsp.config['pyright'] = {
    cmd = { "pyright" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
    on_attach = lsp_on_attach,
  }
  vim.lsp.enable("pyright")
end

if vim.fn.executable("ruff") == 1 then
  vim.lsp.config['ruff'] = {
    cmd = { "ruff" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
    on_attach = lsp_on_attach,
  }
  vim.lsp.enable("ruff")
end

if vim.fn.executable("bash-language-server") == 1 then
  vim.lsp.config['bashls'] = {
    cmd = { "bash-language-server", "start" },
    filetypes = { "bash", "sh" },
    root_markers = { ".git" },
    on_attach = lsp_on_attach,
  }
  vim.lsp.enable("bashls")
end

if vim.fn.executable("gopls") == 1 then
  vim.lsp.config['gopls'] = {
    cmd = { "gopls" },
    filetypes = { "go" },
    root_markers = { "go.mod", ".git" },
    on_attach = lsp_on_attach,
  }
  vim.lsp.enable("gopls")
end

if vim.fn.executable("typescript-language-server") == 1 then
  vim.lsp.config['ts_ls'] = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    root_markers = { "package.json", "tsconfig.json", ".git" },
    on_attach = lsp_on_attach,
  }
  vim.lsp.enable("ts_ls")
end
