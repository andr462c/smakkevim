return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")

      -- Enable Treesitter highligh to all filetypes that there are parsers for.
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          if
          -- is arg2 in arg1
              vim.list_contains(
              -- all installed parsers
                treesitter.get_installed(),
                -- get parser for current language
                vim.treesitter.language.get_lang(args.match)
              )
          then
            vim.treesitter.start(args.buf)
          end
        end,
      })

      -- Treesitter indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      -- put your config here
      require("nvim-treesitter-textobjects").setup {
        select = {
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            -- ['@class.outer'] = '<c-v>', -- blockwise
          },
          -- If you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. Succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
      }
    end,
    keys = {
      -- Select around function (includes signature)
      {
        "am",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        mode = { "x", "o" },
        desc = "around function"
      },
      -- Select inside function (body only)
      {
        "im",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner",
            "textobjects")
        end,
        mode = { "x", "o" },
        desc = "inner function"
      },
      -- Select around class
      {
        "ac",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer",
            "textobjects")
        end,
        mode = { "x", "o" },
        desc = "around class"
      },
      -- Select inside class (body only)
      {
        "ic",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner",
            "textobjects")
        end,
        mode = { "x", "o" },
        desc = "inner class"
      },
      -- Select current scope (block, function, etc.)
      {
        "as",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@local.scope",
            "locals")
        end,
        mode = { "x", "o" },
        desc = "around scope"
      },
      -- Swap current parameter with the next one
      { "<leader>tn", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end,     desc = "swap with next object" },
      -- Swap current parameter with the previous one
      { "<leader>tp", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.outer") end, desc = "swap with previous object" },
    }
  }
}
