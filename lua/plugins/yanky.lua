local function gh(repo)
	return "https://github.com/" .. repo
end

-- [[ Yanky.nvim — Better yank/put with history ring ]]
-- See: https://github.com/gbprod/yanky.nvim
--
-- Adds a yank-ring (kill-ring) so you can cycle through previous yanks
-- after pasting, plus special put commands (auto-indent, shift, filter).
vim.pack.add({ gh("gbprod/yanky.nvim") })

require("yanky").setup({
	ring = {
		history_length = 100,
		storage = "shada", -- persist across sessions via Neovim's ShaDa file
	},
	system_clipboard = {
		-- Only sync with system clipboard when NOT over SSH,
		-- so OSC 52 can take over in SSH sessions.
		-- See `:help clipboard-osc52`
		sync_with_ring = not vim.env.SSH_CONNECTION,
	},
	highlight = {
		on_put = true,
		on_yank = true,
		timer = 150,
	},
	preserve_cursor_position = {
		enabled = true,
	},
})

-- Replace built-in yank/put with yanky versions
vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank text" })
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put after cursor" })
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put before cursor" })
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "Put after and leave cursor after" })
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "Put before and leave cursor after" })

-- Cycle through yank history after a put
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)", { desc = "Cycle previous yank" })
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)", { desc = "Cycle next yank" })

-- Special put commands (vim-unimpaired style)
vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Put indented after" })
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Put indented before" })
vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", { desc = "Put and indent right" })
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", { desc = "Put and indent left" })
vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)", { desc = "Put after applying filter" })

-- vim: ts=2 sts=2 sw=2 et
