return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim"
    },
    opts = {
      ensure_installed = {
        -- HTML/CSS/JS/TS/JSX/TSX
        "html",
        "cssls",
        "cssmodules_ls",
        "ts_ls",
        "eslint",
        "stylelint_lsp",
        "biome@2.4.6",

        -- Python
        "basedpyright",
        "ruff",

        -- Rust
        "rust_analyzer",

        -- Other
        "lua_ls",
        "clangd",
        "sqlls",
        "dockerls",
        "docker_compose_language_service",
        "wgsl_analyzer",
        "copilot",
      }
    }
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        -- Tooling (not lsp)
        "tree-sitter-cli",
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
  }
}
