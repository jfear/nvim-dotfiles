-- [[ mini.nvim ]]
--  A collection of various small independent plugins/modules
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

-- ============================================================================
-- UI & Integration
-- ============================================================================

-- Icons (requires Nerd Font)
if vim.g.have_nerd_font then
	require("mini.icons").setup()
	-- Backwards compatibility for plugins that expect nvim-web-devicons
	MiniIcons.mock_nvim_web_devicons()
end

-- Styled notification UI with history
--
-- Replaces plain vim.notify popups; use `:Notifications` to browse history
require("mini.notify").setup()

-- Route all vim.notify through mini.notify
vim.notify = require("mini.notify").make_notify()

-- ============================================================================
-- Text Editing
-- ============================================================================

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({
	-- NOTE: Avoid conflicts with built-in incremental selection on Neovim>=0.12
	mappings = {
		around_next = "aa",
		inside_next = "ii",
	},
	n_lines = 500,
})

-- Interactive text alignment
--
-- In visual mode: `ga` + target (e.g., `gaip=` aligns paragraph by `=`)
require("mini.align").setup()

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] ['']
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

-- Highlight and auto-trim trailing whitespace on save
require("mini.trailspace").setup()

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("user-trailspace", { clear = true }),
	callback = function()
		require("mini.trailspace").trim()
		require("mini.trailspace").trim_last_lines()
	end,
})

-- Animated vertical line showing current indent scope
require("mini.indentscope").setup({
	symbol = "│",
	options = { try_as_border = true },
})

-- Disable indentscope in certain filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("user-indentscope", { clear = true }),
	pattern = {
		"help",
		"alpha",
		"dashboard",
		"neo-tree",
		"Trouble",
		"trouble",
		"lazy",
		"mason",
		"notify",
		"toggleterm",
		"lazyterm",
		"minifiles",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})

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

-- Split/join argument lists, arrays, etc.
--
-- - gS  : [S]plit current expression into multiple lines
-- - gJ  : [J]oin current expression into single line
require("mini.splitjoin").setup()

-- ============================================================================
-- Navigation
-- ============================================================================

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

-- Delete/wipe buffer while preserving window layout
--
-- Use `<leader>bd` to delete current buffer without closing its window
require("mini.bufremove").setup()

vim.keymap.set("n", "<leader>bd", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "[B]uffer [D]elete (preserve window)" })

-- Track and navigate frequently visited files
--
-- - ]v / [v : Next/prev visited file
require("mini.visits").setup()

-- File explorer with column-based navigation
--
-- - Opens current file's directory; use `~` to go to home, `` ` `` for project root
-- - `<CR>` opens file or directory, `g!` toggles preview, `g.` toggles dotfiles
-- - `m` to set bookmark, `'` to jump to bookmark
require("mini.files").setup()

local minifiles = require("mini.files")

-- Toggle dotfiles visibility in the explorer
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

-- Toggle file preview panel
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

-- Toggle the file explorer for the current buffer's directory
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

-- ============================================================================
-- Statusline
-- ============================================================================

-- Minimal statusline with optional Nerd Font icons
local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })

-- Override location section to show LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

-- vim: ts=2 sts=2 sw=2 et
