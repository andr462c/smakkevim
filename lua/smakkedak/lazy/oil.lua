return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    preview = {
      enabled = true,
      split = "right",
    }
  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  lazy = false,
  config = function()
    require("oil").setup({
    default_file_explorer = true,
   keymaps = {
      ["<C-p>"] = { "actions.preview", opts = { split = 'belowright' }},
    }
  })

  end
}
