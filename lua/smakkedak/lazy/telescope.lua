return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>ff', function()
      local ok = pcall(builtin.git_files)
      if not ok then
        builtin.find_files()
      end
    end, 
    { desc = 'Telescope git files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Telescope word under cursor/selection' })
    -- vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Telescope jump list' })
    vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Telescope jump list' })
    -- LSP keymaps
    vim.keymap.set('n', '<leader>fr', builtin.current_buffer_fuzzy_find, { desc = 'Telescope jump list' })

    local telescope = require('telescope')
    local actions = require('telescope.actions')
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<esc>"] = actions.close,
      },
      n = {
        ["q"] = actions.close,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
      },
    },
  },
})
    -- mappings.default_mappings = config.values.default_mappings
    -- or {
    --     i = {
    --     ["<LeftMouse>"] = {
    --         actions.mouse_click,
    --         type = "action",
    --         opts = { expr = true },
    --     },
    --     ["<2-LeftMouse>"] = {
    --         actions.double_mouse_click,
    --         type = "action",
    --         opts = { expr = true },
    --     },
    --
    --     ["<C-n>"] = actions.move_selection_next,
    --     ["<C-p>"] = actions.move_selection_previous,
    --
    --     ["<C-c>"] = actions.close,
    --
    --     ["<Down>"] = actions.move_selection_next,
    --     ["<Up>"] = actions.move_selection_previous,
    --
    --     ["<CR>"] = actions.select_default,
    --     ["<C-x>"] = actions.select_horizontal,
    --     ["<C-v>"] = actions.select_vertical,
    --     ["<C-t>"] = actions.select_tab,
    --
    --     ["<C-u>"] = actions.preview_scrolling_up,
    --     ["<C-d>"] = actions.preview_scrolling_down,
    --     ["<C-f>"] = actions.preview_scrolling_left,
    --     ["<C-k>"] = actions.preview_scrolling_right,
    --
    --     ["<PageUp>"] = actions.results_scrolling_up,
    --     ["<PageDown>"] = actions.results_scrolling_down,
    --     ["<M-f>"] = actions.results_scrolling_left,
    --     ["<M-k>"] = actions.results_scrolling_right,
    --
    --     ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    --     ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    --     ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    --     ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    --     ["<C-l>"] = actions.complete_tag,
    --     ["<C-/>"] = actions.which_key,
    --     ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
    --     ["<C-w>"] = { "<c-s-w>", type = "command" },
    --     ["<C-r><C-w>"] = actions.insert_original_cword,
    --     ["<C-r><C-a>"] = actions.insert_original_cWORD,
    --     ["<C-r><C-f>"] = actions.insert_original_cfile,
    --     ["<C-r><C-l>"] = actions.insert_original_cline,
    --
    --     -- disable c-j because we dont want to allow new lines #2123
    --     ["<C-j>"] = actions.nop,
    --     },
    --     n = {
    --     ["<LeftMouse>"] = {
    --         actions.mouse_click,
    --         type = "action",
    --         opts = { expr = true },
    --     },
    --     ["<2-LeftMouse>"] = {
    --         actions.double_mouse_click,
    --         type = "action",
    --         opts = { expr = true },
    --     },
    --
    --     ["<esc>"] = actions.close,
    --     ["<CR>"] = actions.select_default,
    --     ["<C-x>"] = actions.select_horizontal,
    --     ["<C-v>"] = actions.select_vertical,
    --     ["<C-t>"] = actions.select_tab,
    --
    --     ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
    --     ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
    --     ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
    --     ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
    --
    --     -- TODO: This would be weird if we switch the ordering.
    --     ["j"] = actions.move_selection_next,
    --     ["k"] = actions.move_selection_previous,
    --     ["H"] = actions.move_to_top,
    --     ["M"] = actions.move_to_middle,
    --     ["L"] = actions.move_to_bottom,
    --
    --     ["<Down>"] = actions.move_selection_next,
    --     ["<Up>"] = actions.move_selection_previous,
    --     ["gg"] = actions.move_to_top,
    --     ["G"] = actions.move_to_bottom,
    --
    --     ["<C-u>"] = actions.preview_scrolling_up,
    --     ["<C-d>"] = actions.preview_scrolling_down,
    --     ["<C-f>"] = actions.preview_scrolling_left,
    --     ["<C-k>"] = actions.preview_scrolling_right,
    --
    --     ["<PageUp>"] = actions.results_scrolling_up,
    --     ["<PageDown>"] = actions.results_scrolling_down,
    --     ["<M-f>"] = actions.results_scrolling_left,
    --     ["<M-k>"] = actions.results_scrolling_right,
    --
    --     ["?"] = actions.which_key,
    --     },
    -- }   vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end

}
