return {
    "neovim/nvim-lspconfig",
    config = function()
    vim.lsp.enable('pyright')
    vim.lsp.enable('rust_analyzer')

    vim.lsp.config('lua_ls', {

    settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false, -- Stops "Do you want to configure your workdir?" prompts
          },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.enable('lua_ls')
    -- Find all default condigs in :help lspconfig-all or
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
  end
}
