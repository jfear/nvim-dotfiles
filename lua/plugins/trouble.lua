-- [[ trouble.nvim ]]
--  A pretty, sortable, filterable diagnostics / quickfix / location list UI.
--
--  Keymaps:
--    <leader>xx  : Toggle diagnostics (all sources)
--    <leader>xX  : Toggle diagnostics (current buffer only)
--    <leader>xL  : Toggle location list
--    <leader>xQ  : Toggle quickfix list
--    [q / ]q     : Previous / next trouble/quickfix item
--
--  Inside the Trouble window:
--    <CR>  : Jump to item
--    o     : Jump without switching focus
--    gO    : Open item in new tab
--    P     : Preview item (keep focus in Trouble)
--    q / <Esc>  : Close window
--    r     : Refresh
--    dd    : Delete / remove item
--    ?     : Show help

vim.pack.add({ "https://github.com/folke/trouble.nvim" })

require("trouble").setup({
	modes = {
		lsp = {
			win = { position = "right" },
		},
	},
})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

vim.keymap.set("n", "[q", function()
	if require("trouble").is_open() then
		require("trouble").prev({ skip_groups = true, jump = true })
	else
		local ok, err = pcall(vim.cmd.cprev)
		if not ok then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end
end, { desc = "Previous Trouble/Quickfix Item" })

vim.keymap.set("n", "]q", function()
	if require("trouble").is_open() then
		require("trouble").next({ skip_groups = true, jump = true })
	else
		local ok, err = pcall(vim.cmd.cnext)
		if not ok then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end
end, { desc = "Next Trouble/Quickfix Item" })

-- vim: ts=2 sts=2 sw=2 et
