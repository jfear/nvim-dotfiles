-- octo.nvim — PR/Issue management for GitHub / GHES
-- Requires `gh` CLI authenticated against the target host:
--   gh auth login --hostname github.yourcompany.com --git-protocol https
vim.pack.add({ { src = "https://github.com/pwntester/octo.nvim", load = false } })

local octo_configured = false
local function ensure_octo()
	if not octo_configured then
		vim.cmd.packadd("octo.nvim")
		require("octo").setup({
			-- TODO: Replace github.yourcompany.com with your actual GHES hostname.
			github_hostname = "github.yourcompany.com",
			use_local_fs = false,
			picker = "telescope",
		})
		octo_configured = true
	end
end

-- Lazy-load octo.nvim when :Octo is invoked for the first time.
vim.api.nvim_create_user_command("Octo", function(opts)
	local args = opts.args
	vim.api.nvim_del_user_command("Octo")
	ensure_octo()
	vim.cmd("Octo " .. args)
end, { nargs = "*" })

vim.keymap.set("n", "<leader>gpo", function()
	ensure_octo()
	vim.cmd("Octo pr list")
end, { desc = "PR list" })

vim.keymap.set("n", "<leader>gpc", function()
	ensure_octo()
	vim.cmd("Octo pr checkout")
end, { desc = "PR checkout" })

vim.keymap.set("n", "<leader>gpr", function()
	ensure_octo()
	vim.cmd("Octo review start")
end, { desc = "PR review" })

vim.keymap.set("n", "<leader>gpi", function()
	ensure_octo()
	vim.cmd("Octo issue list")
end, { desc = "Issue list" })

vim.keymap.set("n", "<leader>gpn", function()
	ensure_octo()
	vim.cmd("Octo pr create")
end, { desc = "PR create" })

-- vim: ts=2 sts=2 sw=2 et
