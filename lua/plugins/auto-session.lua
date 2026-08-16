-- auto-session — per-branch session save/restore
-- Must load at startup so the correct branch's session is restored.
vim.pack.add({ { src = "https://github.com/rmagatti/auto-session", load = true } })

require("auto-session").setup({
	-- Save a separate session per git branch
	git_use_branch_name = true,
	-- Auto-restore the right session when you switch branches
	git_auto_restore_on_branch_change = true,
	-- Suppress the session restore message in home/Downloads
	suppressed_dirs = { "~/", "~/Downloads" },
	-- Don't save these filetypes into sessions
	bypass_session_save_file_types = {
		"neo-tree",
		"NvimTree",
		"Neogit*",
		"trouble",
	},
})

-- Use <leader>a* for auto-session. <leader>s* is taken by telescope and
-- <leader>S* collides with snacks.nvim's <leader>S scratch mapping.
-- This is temporary; we'll do a full keymap review once the workflow lands.
vim.keymap.set("n", "<leader>as", "<cmd>SessionSave<cr>", { desc = "Save session" })
vim.keymap.set("n", "<leader>ar", "<cmd>SessionRestore<cr>", { desc = "Restore session" })
vim.keymap.set("n", "<leader>af", "<cmd>SessionSearch<cr>", { desc = "Find sessions" })
vim.keymap.set("n", "<leader>ad", "<cmd>SessionDelete<cr>", { desc = "Delete session" })

-- vim: ts=2 sts=2 sw=2 et
