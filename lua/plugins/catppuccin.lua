vim.pack.add({ "https://github.com/catppuccin/nvim" })
require("catppuccin").setup({
	flavour = "mocha",
	no_italic = true,
})
vim.cmd.colorscheme("catppuccin")
