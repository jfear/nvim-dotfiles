-- [[ mini.nvim ]]
--  A collection of various small independent plugins/modules
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
	require("mini.icons").setup()
	-- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
	MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({
	-- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
	mappings = {
		around_next = "aa",
		inside_next = "ii",
	},
	n_lines = 500,
})

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

-- Move lines and selections with Alt + hjkl
--
-- - M-h  - [M]ove left
-- - M-j  - [M]ove down
-- - M-k  - [M]ove up
-- - M-l  - [M]ove right
require("mini.move").setup()

-- Automatic character pair insertion and deletion
--
-- Treesitter-aware: skips closing a pair when there's already a matching one ahead
require("mini.pairs").setup()

-- Text edit operators
--
-- - g=  : Evaluate text and replace with result
-- - cx  : Exchange two text regions (cx + motion, then cx + motion)
-- - gm  : Multiply (duplicate) text
-- - cr  : Replace text with register contents
-- - gs  : Sort lines or comma/space-separated items
--
-- Prefixes chosen to avoid conflicts:
--   'gr' is used by LSP mappings (grr, gri, grd, etc.)
--   'gx' is Neovim built-in URL opener
require("mini.operators").setup({
	exchange = { prefix = "cx" },
	replace = { prefix = "cr" },
})

-- Square bracket navigation
--
-- ]b / [b : Next/prev buffer          ]d / [d : Next/prev diagnostic
-- ]f / [f : Next/prev file in dir      ]q / [q : Next/prev quickfix
-- ]x / [x : Next/prev git conflict     ]c / [c : Next/prev comment block
-- ]o / [o : Next/prev old file         ]t / [t : Next/prev treesitter node
-- ]j / [j : Next/prev jump             ]w / [w : Next/prev window
-- ]i / [i : Next/prev indent change    ]y / [y : Next/prev yank entry
--
-- 'undo' target is disabled to avoid remapping 'u' and '<C-R>'
require("mini.bracketed").setup({
	undo = { suffix = "" },
})

-- File explorer with column-based navigation
--
-- - Opens current file's directory; use `~` to go to home, `` ` `` for project root
-- - `<CR>` opens file or directory, `g!` toggles preview, `g.` toggles dotfiles
-- - `m` to set bookmark, `'` to jump to bookmark
require("mini.files").setup()

local minifiles = require("mini.files")

-- Toggle dotfiles visibility
local show_dotfiles = true
local filter_show = function(_)
	return true
end
local filter_hide = function(fs_entry)
	return not vim.startswith(fs_entry.name, ".")
end
local toggle_dotfiles = function()
	show_dotfiles = not show_dotfiles
	local new_filter = show_dotfiles and filter_show or filter_hide
	minifiles.refresh({ content = { filter = new_filter } })
end

-- Toggle file preview
local show_preview = false
local toggle_preview = function()
	show_preview = not show_preview
	minifiles.refresh({ windows = { preview = show_preview } })
end

-- Register buffer-local mappings when a mini.files explorer opens
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles" })
		vim.keymap.set("n", "g!", toggle_preview, { buffer = buf_id, desc = "Toggle preview" })
	end,
})

local function toggle_explorer()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "minifiles" then
			minifiles.close()
			return
		end
	end
	minifiles.open(vim.api.nvim_buf_get_name(0), true)
end

vim.keymap.set("n", "<leader>e", toggle_explorer, { desc = "[E]xplorer (mini.files)" })

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require("mini.statusline")
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

-- vim: ts=2 sts=2 sw=2 et
