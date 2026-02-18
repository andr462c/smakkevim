local which_key = require("which-key")

-- Util functions
local function copy_git_hash()
  local file = vim.fn.expand("%")
  local line = vim.fn.line(".")

  local cmd = string.format("git blame -L %d,%d --porcelain %s", line, line, file)
  local output = vim.fn.system(cmd)

  -- The hash is the first 40 characters (or the first space-delimited word)
  local hash = output:match("^(%x+)")

  if hash == '0000000000000000000000000000000000000000' then
    print("Not a commit")
  end
  if hash then
    vim.fn.setreg("+", hash) -- Copy to system clipboard
    print("Copied " .. hash)
  else
    print("Zero-day commit or not a git repo.")
  end
end

local function toggle_virtual_lines()
    local new_config = not vim.diagnostic.config().virtual_lines
    vim.diagnostic.config({ virtual_lines = new_config , virtual_text = not new_config})
end

local function open_git_gui_blame()
  local file = vim.fn.expand("%")
  local line = vim.fn.line(".")
  vim.fn.jobstart({ "git", "gui", "blame", "--line=" .. line, file }, { detach = true })
end

which_key.add({
  {
    "<leader>E",
    function()
      require('oil').open(nil, { preview = { split = 'belowright' } })
    end,
    desc = "Open file explorer"
  },
  { "<C-d>",     "<C-d>zz",          desc = "Half page down and center" },
  { "<C-d>",     "<C-d>zz",          desc = "Half page down and center" },
  { "<C-u>",     "<C-u>zz",          desc = "Half page up and center" },
  { "<leader>F", vim.lsp.buf.format, desc = "Format buffer" },
  { "<leader>p", '"_dP',             desc = "Paste without overwrite" },
  { "J",         "mzJ`z",            desc = "Join lines and keep cursor position" },
   --  Git
   { "<leader>gb", ":Gitsigns blame<CR>",                     desc = "View git blame for file" },
   { "<leader>gg", open_git_gui_blame,                        desc = "Open git GUI blame for file" },
   { "<leader>gtl", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle inline git blame" },
  { "<leader>gr", ":Gitsigns reset_hunk<CR>",                desc = "Reset git chunk" },
  { "<leader>gp", ":Gitsigns preview_hunk_inline<CR>",       desc = "Inline chunk preview" },
  { "<leader>gp", ":Gitsigns preview_hunk_inline<CR>",       desc = "Inline chunk preview" },
  { "<leader>g]", ":Gitsigns nav_hunk next<CR>",             desc = "Navigate to next git chunk" },
  { "<leader>g[", ":Gitsigns nav_hunk prev<CR>",             desc = "Navigate to prev git chunk" },
  { "<leader>gy", copy_git_hash,                             desc = "Copy commit hash at cursor" },
   {
     mode = { 'n' },
     -- Diagnostic
     { "gK", toggle_virtual_lines, desc = "Toggle virtual lines diagnostics"},
     { "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to next error" },
     { "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to previous error" },
     -- Navigate windows using Ctrl + hjkl
     { '<C-h>', '<C-w>h', desc = 'Go to Left Window' },
     { '<C-j>', '<C-w>j', desc = 'Go to Lower Window' },
     { '<C-k>', '<C-w>k', desc = 'Go to Upper Window' },
     { '<C-l>', '<C-w>l', desc = 'Go to Right Window' },
   }
  -- Example
  -- {
  --   "<leader>b",
  --   group = "buffers",
  --   expand = function()
  --     return require("which-key.extras").expand.buf()
  --   end
  -- },
  --  {
  --    -- Nested mappings are allowed and can be added in any order
  --    -- Most attributes can be inherited or overridden on any level
  --    -- There's no limit to the depth of nesting
  --    mode = { "n", "v" }, -- NORMAL and VISUAL mode
  --    { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
  --    { "<leader>w", "<cmd>w<cr>", desc = "Write" },
  --  }
})
