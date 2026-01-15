local which_key = require("which-key")
which_key.add({
    --{ "<leader>e", ":Oil\n", desc = "Open file explorer" },
    { "<leader>e", function()
      require('oil').open(nil, {preview = {split='belowright'}} )
    end, desc = "Open file explorer" },
    { "<C-d>", "<C-d>zz", desc = "Half page down and center" },
    { "<C-d>", "<C-d>zz", desc = "Half page down and center" },
    { "<C-u>", "<C-u>zz", desc = "Half page up and center" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
    { "<leader>p", '"_dP', desc = "Paste without overwrite" },
    --{ "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", desc = "Search and replace word under cursor" },
    { "J", "mzJ`z", desc = "Join lines and keep cursor position" },
   { "<leader>b", group = "buffers", expand = function()
      return require("which-key.extras").expand.buf()
    end
  },
  -- Example
--  {
--    -- Nested mappings are allowed and can be added in any order
--    -- Most attributes can be inherited or overridden on any level
--    -- There's no limit to the depth of nesting
--    mode = { "n", "v" }, -- NORMAL and VISUAL mode
--    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
--    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
--  }
  })
