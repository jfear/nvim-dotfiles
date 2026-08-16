-- Flash.nvim — jump to any visible character or treesitter node
--
-- NOTE: This remaps 's' (substitute character). Use 'cl' for the same behavior.
-- 'S' is also remapped for treesitter-aware selection.
--
-- - s + char       : Jump to character anywhere on screen
-- - S              : Flash Treesitter — jump to functions, classes, etc.
-- - <C-s> in /?   : Toggle flash during search
vim.pack.add({ "https://github.com/folke/flash.nvim" })

local flash = require("flash")
flash.setup()

vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("c", "<C-s>", flash.toggle, { desc = "Toggle Flash search" })
