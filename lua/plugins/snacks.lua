-- [[ snacks.nvim ]]
--  A collection of quality-of-life utilities by folke.
--  Only non-overlapping modules are enabled to avoid duplicating mini.nvim features.
--
--  Enabled modules:
--    bigfile    : Disable heavy features (indent, LSP, etc.) on very large files
--    quickfile  : Skip Treesitter/indent for the first N ms while opening files
--    scratch    : Toggle and manage scratch buffers
--    input      : Better UI for vim.ui.input prompts (e.g., rename, search)
--
--  Keymaps:
--    <leader>.  : Toggle scratch buffer
--    <leader>S  : Select / list scratch buffers

vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	bigfile = { enabled = true },
	quickfile = { enabled = true },
	scratch = { enabled = true },
	input = { enabled = true },
})

vim.keymap.set("n", "<leader>.", function()
	require("snacks").scratch()
end, { desc = "Toggle Scratch Buffer" })

vim.keymap.set("n", "<leader>S", function()
	require("snacks").scratch.select()
end, { desc = "Select Scratch Buffer" })

-- vim: ts=2 sts=2 sw=2 et
