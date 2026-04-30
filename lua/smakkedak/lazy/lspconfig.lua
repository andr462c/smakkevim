return {
  "neovim/nvim-lspconfig",
  opts = {
    automatic_servers_installation = true,
  },
  config = function()
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = "Neovim" },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          completion = { callSnippet = "Replace" },
          hint = { enable = true },
        },
      },
    })

    vim.lsp.config('rust_analyzer', {
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          -- checkOnSave = { command = "clippy" },
        },
      },
    })

    vim.lsp.config('basedpyright', {
      settings = {
        basedpyright = {
          typeCheckingMode = "basic",
        },
      },
    })

    vim.lsp.config('clangd', {
      settings = {
        clangd = {
          fallbackFlags = { "-std=c++17" },
        },
      },
    })
  end,
}
