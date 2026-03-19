return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local adapters = require("codecompanion.adapters")
    require("codecompanion").setup({
      adapters = {
        gemini = adapters.extend("gemini", {
          env = { api_key = "AIzaSyDNG22TYAk6tsXd6ygg_ENuhs47kNiPtKE" },
          schema = { model = { default = "gemini-2.0-flash" } },
        }),
      },
      strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
        agent = { adapter = "gemini" },
      },
    })
  end,
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "AI Inline" },
  },
}
