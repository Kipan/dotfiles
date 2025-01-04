local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-g>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	require('telescope.builtin').live_grep({
		search_dirs = { vim.fn.getcwd() },
		additional_args = function(opts)
			return { '--ignore-case' }  -- Case-insensitive search
		end
	})
end)
