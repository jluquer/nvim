return {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { "j-hui/fidget.nvim",       opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",
  },
  config = function()
    -- UI Popup borders
    local float_style = { border = "rounded" }
    local icons = require "utils.icons"
    local default_diagnostic_config = {
      signs = {
        active = true,
        values = {
          { name = "DiagnosticSignError", text = icons.diagnostics.Error },
          { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
          { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
          { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
        },
      },
      virtual_text = false,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = float_style,
    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_style)
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_style)
    require("lspconfig.ui.windows").default_options.border = "rounded"
    vim.cmd [[highlight! link NormalFloat Text]]
    vim.diagnostic.config(default_diagnostic_config)

    for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
      vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
    end

    -- [[ Configure LSP ]]
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>lr", vim.lsp.buf.rename, "Rename")
      nmap("<leader>la", vim.lsp.buf.code_action, "Code [A]ction")
      nmap("<leader>lf", vim.lsp.buf.format, "Format Code")

      nmap("gl", vim.diagnostic.open_float, "Float diagnostic")
      nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
      nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
      nmap("<leader>ls", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("J", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Lesser used LSP functionality
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    -- mason-lspconfig requires that these setup functions are called in this order
    -- before setting up the servers.
    require("mason").setup()
    require("mason-lspconfig").setup()

    local servers = {
      -- clangd = {},
      gopls = {},
      cssls = {
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
            format = {
              enable = false,
            },
            -- customData = { ".css-data.json" },
          },
        },
      },
      pyright = {},
      -- rust_analyzer = {},
      tsserver = {},
      html = { filetypes = { "html", "twig", "hbs" } },
      tailwindcss = {},
      eslint = {},
      dockerls = {},
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = "",
            },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      },
      bashls = {
        filetypes = { "sh", "zsh", "bash" },
        settings = {
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command|.zsh|zshrc|zsh_*)",
          },
        },
      },
      astro = {},
      marksman = {},
      lua_ls = {
        settings = {
          Lua = {
            format = {
              enable = false,
            },
            diagnostics = {
              globals = { "vim", "spec" },
            },
            runtime = {
              version = "LuaJIT",
              special = {
                spec = "require",
              },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.stdpath "config" .. "/lua"] = true,
              },
            },
            hint = {
              enable = false,
              arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
              await = true,
              paramName = "Disable",  -- "All" | "Literal" | "Disable"
              paramType = true,
              semicolon = "All",      -- "All" | "SameLine" | "Disable"
              setType = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    }

    -- Setup neovim lua configuration
    require("neodev").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require "mason-lspconfig"

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end,
    }

    -- [[ Autoformat ]]
    --  Use :FormatToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command("FormatToggle", function()
      format_is_enabled = not format_is_enabled
      print("Setting autoformatting to: " .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = "lsp-format-" .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- Tsserver usually works poorly.
        if client.name == "tsserver" then
          return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })
  end,
}
