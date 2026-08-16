-- Diffview.nvim — full git diff/merge interface
--
-- :DiffviewOpen        : Open diff for current branch
-- :DiffviewFileHistory : Browse file history
--
-- Keymaps:
--   <leader>gd : Open Diffview (current branch)
--   <leader>gf : Open file history for current file
vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "[G]it [D]iffview open" })
vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", { desc = "[G]it [F]ile history" })
