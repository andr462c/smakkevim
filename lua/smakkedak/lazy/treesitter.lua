return {
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
}
