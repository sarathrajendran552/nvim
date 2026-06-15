return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>l", group = "LSP" },
      { "<leader>g", group = "Grep" },
    })
  end,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Show local keymaps",
    },
  },
}
