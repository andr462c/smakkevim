return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local configs = require("nvim-treesitter")
 
    configs.setup({
      ensure_installed = {
        "rust","c", "lua", "vim", "vimdoc", "elixir", "javascript", "html", "python", "typescript"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
