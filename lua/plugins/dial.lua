-- [[ dial.nvim ]]
--  Smart increment/decrement — cycles booleans, dates, weekdays, hex colors, semver, etc.
--  Replaces the built-in <C-a>/<C-x> with context-aware cycling.
--
--  In normal or visual mode:
--    <C-a>   : Increment
--    <C-x>   : Decrement
--    g<C-a>  : Increment (all occurrences in visual selection)
--    g<C-x>  : Decrement (all occurrences in visual selection)

vim.pack.add({ "https://github.com/monaqa/dial.nvim" })

local augend = require("dial.augend")

local function dial_map(increment, g)
	local mode = vim.fn.mode(true)
	local is_visual = mode == "v" or mode == "V" or mode == "\22"
	local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
	local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
	return require("dial.map")[func](group)
end

vim.keymap.set({ "n", "v" }, "<C-a>", function()
	return dial_map(true)
end, { expr = true, desc = "Increment (dial)" })
vim.keymap.set({ "n", "v" }, "<C-x>", function()
	return dial_map(false)
end, { expr = true, desc = "Decrement (dial)" })
vim.keymap.set({ "n", "x" }, "g<C-a>", function()
	return dial_map(true, true)
end, { expr = true, desc = "Increment all (dial)" })
vim.keymap.set({ "n", "x" }, "g<C-x>", function()
	return dial_map(false, true)
end, { expr = true, desc = "Decrement all (dial)" })

-- Logical operators (&& <-> ||)
local logical_alias = augend.constant.new({
	elements = { "&&", "||" },
	word = false,
	cyclic = true,
})

-- Ordinal numbers
local ordinal_numbers = augend.constant.new({
	elements = {
		"first",
		"second",
		"third",
		"fourth",
		"fifth",
		"sixth",
		"seventh",
		"eighth",
		"ninth",
		"tenth",
	},
	word = false,
	cyclic = true,
})

-- Months
local months = augend.constant.new({
	elements = {
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December",
	},
	word = true,
	cyclic = true,
})

local groups = {
	default = {
		augend.integer.alias.decimal,
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.constant.alias.en_weekday,
		augend.constant.alias.en_weekday_full,
		ordinal_numbers,
		months,
		augend.constant.alias.bool,
		augend.constant.alias.Bool,
		logical_alias,
	},
	typescript = {
		augend.constant.new({ elements = { "let", "const" } }),
	},
	css = {
		augend.hexcolor.new({ case = "lower" }),
		augend.hexcolor.new({ case = "upper" }),
	},
	markdown = {
		augend.constant.new({
			elements = { "[ ]", "[x]" },
			word = false,
			cyclic = true,
		}),
		augend.misc.alias.markdown_header,
	},
	json = {
		augend.semver.alias.semver,
	},
	lua = {
		augend.constant.new({
			elements = { "and", "or" },
			word = true,
			cyclic = true,
		}),
	},
	python = {
		augend.constant.new({
			elements = { "and", "or" },
		}),
	},
}

-- Merge defaults into each filetype group
for name, group in pairs(groups) do
	if name ~= "default" then
		vim.list_extend(group, groups.default)
	end
end

require("dial.config").augends:register_group(groups)

vim.g.dials_by_ft = {
	css = "css",
	scss = "css",
	sass = "css",
	javascript = "typescript",
	typescript = "typescript",
	typescriptreact = "typescript",
	javascriptreact = "typescript",
	json = "json",
	lua = "lua",
	markdown = "markdown",
	python = "python",
}

-- vim: ts=2 sts=2 sw=2 et
