-- Modern replacement for YouCompleteMe: LSP + completion via mason/lspconfig/cmp
return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "ts_ls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- lua_ls/pyright/ts_ls/ruff come from Mason; clangd and sourcekit-lsp
      -- are provided by Xcode command line tools and picked up from PATH.
      local servers = { "lua_ls", "pyright", "ts_ls", "clangd", "sourcekit", "ruff" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end

      -- Ruff's own defaults only enable E4/E7/E9/F (a small pyflakes-ish
      -- slice). Broaden it here so it actually replaces the breadth of
      -- pylint's default checks: naming (N), pyupgrade (UP), bugbear (B),
      -- simplify (SIM), complexity (C90) and ruff's own pylint port (PL).
      vim.lsp.config("ruff", {
        init_options = {
          settings = {
            lint = {
              select = { "E", "W", "F", "I", "N", "UP", "B", "SIM", "C90", "PL" },
            },
          },
        },
      })

      -- ruff handles python linting/imports/quick-fixes; let pyright keep
      -- owning hover and type-based completion so they don't fight over it
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
      })

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
