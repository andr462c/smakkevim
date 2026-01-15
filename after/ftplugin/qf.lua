local opts = { buffer = true, silent = true }

-- preview 
vim.keymap.set("n", "p", "<CR>zz<C-w>p", opts)

-- close
vim.keymap.set("n", "q", ":close<CR>", opts)

-- Use 'j' and 'k' to preview items without leaving the list
vim.keymap.set("n", "j", "j<CR>zz<C-w>p", opts)
vim.keymap.set("n", "k", "k<CR>zz<C-w>p", opts)

-- Press 'dd' to remove an item from the quickfix list
vim.keymap.set("n", "dd", function()
  local qf_list = vim.fn.getqflist()
  if # qf_list == 1 then
    vim.cmd("close")
    return
  end

  local cur_line = vim.fn.line(".")
  table.remove(qf_list, cur_line)
  vim.fn.setqflist(qf_list, "r")
  vim.cmd(cur_line .. "cfirst") -- Stay on the same line
  vim.cmd("copen")              -- Refresh window
end, opts)
