return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
  config = function()
    local lspconfig = require "plugins.lsp-config"
    require("typescript-tools").setup {
      on_attach = function(client, bufnr)
        vim.keymap.set(
          "n",
          "<leader>lto",
          "<cmd>TSToolsOrganizeImports<cr>",
          { buffer = bufnr, desc = "Organize Imports" }
        )
        vim.keymap.set("n", "<leader>lts", "<cmd>TSToolsSortImports<cr>", { buffer = bufnr, desc = "Sort Imports" })
        vim.keymap.set(
          "n",
          "<leader>ltu",
          "<cmd>TSToolsRemoveUnused<cr>",
          { buffer = bufnr, desc = "Removed Unused statements" }
        )
        vim.keymap.set(
          "n",
          "<leader>lti",
          "<cmd>TSToolsGoToSourceDefinition<cr>",
          { buffer = bufnr, desc = "Go To Source Definition" }
        )
        vim.keymap.set(
          "n",
          "<leader>ltr",
          "<cmd>TSToolsRemoveUnusedImports<cr>",
          { buffer = bufnr, desc = "Removed Unused Imports" }
        )
        vim.keymap.set("n", "<leader>ltf", "<cmd>TSToolsFixAll<cr>", { buffer = bufnr, desc = "Fix All" })
        vim.keymap.set(
          "n",
          "<leader>lta",
          "<cmd>TSToolsAddMissingImports<cr>",
          { buffer = bufnr, desc = "Add Missing Imports" }
        )
        lspconfig.on_attach(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
      -- capabilities = set to cmp capabilities as lsp,
      settings = {
        jsx_close_tag = {
          enable = true,
          filetypes = { "javascriptreact", "typescriptreact" },
        },
      },
    }
  end,
}
