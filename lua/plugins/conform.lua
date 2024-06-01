local prettier_ft = { "prettier" }

local templ_format = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local cmd = "templ fmt " .. vim.fn.shellescape(filename)

  vim.fn.jobstart(cmd, {
    on_exit = function()
      -- Reload the buffer only if it's still the current buffer
      if vim.api.nvim_get_current_buf() == bufnr then
        vim.cmd "e!"
      end
    end,
  })
end

return {
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<leader>lf",
      function()
        if vim.bo.filetype ~= "templ" then
          require("conform").format { async = true, lsp_fallback = true }
        else
          templ_format()
        end
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local ignore_filetypes = { "templ" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        vim.notify("formatting on save ft " .. vim.bo[bufnr].filetype)
        if vim.bo[bufnr].filetype == "templ" then
          templ_format()
        end
        return
      end

      if vim.g.disable_autoformat then
        return
      end

      local disable_filetypes_lsp_fallback = { c = true, cpp = true }
      return {
        timeout_ms = 2000,
        lsp_fallback = not disable_filetypes_lsp_fallback[vim.bo[bufnr].filetype],
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
      sql = { "sql_formatter" },
    },
    formmaters = {
      prettier = {
        prepend_args = { "--single-quote", "--jsx-single-quote", "--single-attribute-per-line" },
      },
      sql_formatter = {
        command = "sql-formatter",
      },
    },
  },
}
