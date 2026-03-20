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

virtual_text_state = vim.diagnostic.config().virtual_text
virtual_lines_state = vim.diagnostic.config().virtual_lines

local function set_diagnostic_config()
  vim.diagnostic.config({ virtual_lines = virtual_lines_state, virtual_text = not virtual_lines_state and virtual_text_state })
end

local function toggle_virtual_text()
  virtual_text_state = not vim.diagnostic.config().virtual_text
  set_diagnostic_config()
end

local function toggle_virtual_lines()
  virtual_lines_state = not vim.diagnostic.config().virtual_lines
  set_diagnostic_config()
end

local function open_git_gui_blame()
  local file = vim.fn.expand("%")
  local line = vim.fn.line(".")
  vim.fn.jobstart({ "git", "gui", "blame", "--line=" .. line, file }, { detach = true })
end

which_key.add({
  { "<C-d>",       "<C-d>zz",                                 desc = "Half page down and center" },
  { "<C-u>",       "<C-u>zz",                                 desc = "Half page up and center" },
  { "<leader>F",   vim.lsp.buf.format,                        desc = "Format buffer" },
  { "<leader>p",   '"_dP',                                    desc = "Paste without overwrite" },
  { "J",           "mzJ`z",                                   desc = "Join lines and keep cursor position" },
  --  Git
  { "<leader>gb",  ":Gitsigns blame<CR>",                     desc = "View git blame for file" },
  { "<leader>gg",  open_git_gui_blame,                        desc = "Open git GUI blame for file" },
  { "<leader>gtl", ":Gitsigns toggle_current_line_blame<CR>", desc = "Toggle inline git blame" },
  { "<leader>gr",  ":Gitsigns reset_hunk<CR>",                desc = "Reset git chunk" },
  { "<leader>gp",  ":Gitsigns preview_hunk_inline<CR>",       desc = "Inline chunk preview" },
  { "<leader>g]",  ":Gitsigns nav_hunk next<CR>",             desc = "Navigate to next git chunk" },
  { "<leader>g[",  ":Gitsigns nav_hunk prev<CR>",             desc = "Navigate to prev git chunk" },
  { "<leader>gy",  copy_git_hash,                             desc = "Copy commit hash at cursor" },
  {
    mode = { 'n' },
    -- Diagnostic
    { "gL",    toggle_virtual_lines,                                                                 desc = "Toggle virtual lines diagnostics" },
    { "gT",    toggle_virtual_text,                                                                  desc = "Toggle virtual text diagnostics" },
    { "]e",    function() vim.diagnostic.nav_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to next error" },
    { "[e",    function() vim.diagnostic.nav_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Go to previous error" },
    -- Navigate windows using Ctrl + hjkl
    { '<C-h>', '<C-w>h',                                                                             desc = 'Go to Left Window' },
    { '<C-j>', '<C-w>j',                                                                             desc = 'Go to Lower Window' },
    { '<C-k>', '<C-w>k',                                                                             desc = 'Go to Upper Window' },
    { '<C-l>', '<C-w>l',                                                                             desc = 'Go to Right Window' },
  }
})
