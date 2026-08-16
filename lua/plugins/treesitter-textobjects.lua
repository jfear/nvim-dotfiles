-- [[ nvim-treesitter-textobjects ]]
--  Treesitter-aware movement and selection for functions, classes, parameters, etc.
--
--  Movement:
--    ]f / [f  : Next/prev function start
--    ]F / [F  : Next/prev function end
--    ]c / [c  : Next/prev class start
--    ]C / [C  : Next/prev class end
--    ]a / [a  : Next/prev parameter/argument start
--    ]A / [A  : Next/prev parameter/argument end
--
--  Selection (visual mode):
--    if / af  : Inside/around function
--    ic / ac  : Inside/around class
--    ia / aa  : Inside/around parameter

vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" } })

require("nvim-treesitter-textobjects").setup({
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			["]f"] = "@function.outer",
			["]c"] = "@class.outer",
			["]a"] = "@parameter.inner",
		},
		goto_next_end = {
			["]F"] = "@function.outer",
			["]C"] = "@class.outer",
			["]A"] = "@parameter.inner",
		},
		goto_previous_start = {
			["[f"] = "@function.outer",
			["[c"] = "@class.outer",
			["[a"] = "@parameter.inner",
		},
		goto_previous_end = {
			["[F"] = "@function.outer",
			["[C"] = "@class.outer",
			["[A"] = "@parameter.inner",
		},
	},
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
		},
	},
})

-- vim: ts=2 sts=2 sw=2 et
