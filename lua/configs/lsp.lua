local status, nvim_lsp = pcall(require, "lspconfig")

if not status then
  return
end

local protocol = require("vim.lsp.protocol")

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
  end,
})

local on_attach = function(client, bufnr)
  status.on_attach(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.formatting_seq_sync()
      end,
    })
  end
end


local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- TypeScript
nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Java
nvim_lsp.jdtls.setup({
  capabilities = capabilities,
})

-- Lua
nvim_lsp.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
})

-- CSS
nvim_lsp.cssls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Tailwind
nvim_lsp.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- HTML
nvim_lsp.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- JSON
nvim_lsp.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Eslint
nvim_lsp.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Python
nvim_lsp.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
