local prettier_ft = { "prettier" }
return {
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 2000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { { "shfmt", "beautysh" } },
      javascript = prettier_ft,
      javascriptreact = prettier_ft,
      typescript = prettier_ft,
      typescriptreact = prettier_ft,
      css = prettier_ft,
      html = prettier_ft,
      json = prettier_ft,
      yaml = prettier_ft,
      markdown = prettier_ft,
      graphql = prettier_ft,
    },
    formmaters = {
      prettier = {
        prepend_args = { "--single-quote", "--jsx-single-quote", "--single-attribute-per-line" },
      },
    },
  },
}
