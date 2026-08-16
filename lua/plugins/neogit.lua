-- Neogit — interactive git interface (status, commit, rebase, push, branch, log)
-- Opens PR compare URLs for both github.com and GHES via the branch popup (`b o`).
vim.pack.add({ { src = "https://github.com/NeogitOrg/neogit", load = false } })

local neogit_configured = false
local function ensure_neogit()
	if not neogit_configured then
		vim.cmd.packadd("neogit")
		require("neogit").setup({
			integrations = { diffview = true, telescope = true },
			kind = "tab",
			rebase_editor = { kind = "auto" },
			git_services = {
				["github.com"] = {
					pull_request = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
					commit = "https://github.com/${owner}/${repository}/commit/${oid}",
					tree = "https://github.com/${owner}/${repository}/tree/${branch_name}",
				},
				-- TODO: Replace github.yourcompany.com with your actual GHES hostname.
				["github.yourcompany.com"] = {
					pull_request = "https://github.yourcompany.com/${owner}/${repository}/compare/${branch_name}?expand=1",
					commit = "https://github.yourcompany.com/${owner}/${repository}/commit/${oid}",
					tree = "https://github.yourcompany.com/${owner}/${repository}/tree/${branch_name}",
				},
			},
		})
		neogit_configured = true
	end
end

-- Lazy-load neogit when :Neogit is invoked for the first time.
vim.api.nvim_create_user_command("Neogit", function(opts)
	local args = opts.args
	vim.api.nvim_del_user_command("Neogit")
	ensure_neogit()
	vim.cmd("Neogit " .. args)
end, { nargs = "*" })

vim.keymap.set("n", "<leader>gg", function()
	ensure_neogit()
	vim.cmd("Neogit")
end, { desc = "Neogit status" })

vim.keymap.set("n", "<leader>gc", function()
	ensure_neogit()
	vim.cmd("Neogit commit")
end, { desc = "Neogit commit" })

vim.keymap.set("n", "<leader>gP", function()
	ensure_neogit()
	vim.cmd("Neogit push")
end, { desc = "Neogit push" })

vim.keymap.set("n", "<leader>gb", function()
	ensure_neogit()
	vim.cmd("Neogit branch")
end, { desc = "Neogit branch" })

vim.keymap.set("n", "<leader>gl", function()
	ensure_neogit()
	vim.cmd("Neogit log")
end, { desc = "Neogit log" })

-- vim: ts=2 sts=2 sw=2 et
