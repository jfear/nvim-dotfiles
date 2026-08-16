-- quickfix-review.nvim — annotate hunks in diffview/files and export for AI review
vim.pack.add({ { src = "https://github.com/MMesch/quickfix-review-nvim", load = false } })

-- Keymap configuration shared between setup() and our lazy-load wrappers.
local qfr_keymaps = {
	add_comment_cycle = "<leader>ca",
	cycle_next = "<M-+>",
	cycle_previous = "<M-->",
	delete_comment = "<leader>cd",
	export = "<leader>ce",
	clear = "<leader>cc",
	summary = "<leader>cS",
	save = "<leader>cw",
	load = "<leader>crr",
	open_list = "<leader>co",
	next_comment = "]r",
	prev_comment = "[r",
	goto_real_file = "<leader>cg",
	view = "<leader>cv",
}

-- Comment types and the keys that trigger them. The plugin auto-generates
-- keymaps like add_issue/add_suggestion from these entries during setup().
local comment_types = {
	{ key = "<leader>ci", type = "ISSUE", cfg = "add_issue" },
	{ key = "<leader>cs", type = "SUGGESTION", cfg = "add_suggestion" },
	{ key = "<leader>cn", type = "NOTE", cfg = "add_note" },
	{ key = "<leader>cp", type = "PRAISE", cfg = "add_praise" },
	{ key = "<leader>cq", type = "QUESTION", cfg = "add_question" },
	{ key = "<leader>ck", type = "INSIGHT", cfg = "add_insight" },
	{ key = "<leader>cA", type = "AGENT", cfg = "add_agent" },
}

for _, ct in ipairs(comment_types) do
	qfr_keymaps[ct.cfg] = ct.key
end

local qfr_configured = false

-- Load the plugin once, call setup(), and return the module.
local function ensure_qfr()
	if not qfr_configured then
		vim.cmd.packadd("quickfix-review-nvim")
		require("quickfix-review").setup({
			-- Keep out of source — one file per git repo
			storage_file = vim.fn.stdpath("data") .. "/quickfix-review.json",
			-- Export to clipboard only, no file clutter
			export_file = nil,
			-- Warn when annotated file changes under you (useful after agent edits)
			prompt_on_file_change = true,
			-- Extra type for agent-specific instructions vs. self-notes
			additional_comment_types = {
				agent = {
					sign = "🤖",
					highlight = "DiagnosticInfo",
					description = "Agent instruction",
				},
			},
			keymaps = qfr_keymaps,
		})
		qfr_configured = true
	end
	return require("quickfix-review")
end

-- Typed comment wrappers ----------------------------------------------------
for _, ct in ipairs(comment_types) do
	vim.keymap.set("n", ct.key, function()
		ensure_qfr().add_comment(ct.type)
	end, { desc = "Review: add " .. ct.type })

	vim.keymap.set("v", ct.key, function()
		ensure_qfr().add_comment_visual(ct.type)
	end, { desc = "Review: add " .. ct.type })
end

-- Cycle add (normal): direct API call.
vim.keymap.set("n", "<leader>ca", function()
	ensure_qfr().add_comment_cycle()
end, { desc = "Review: add (current type)" })

-- Cycle add (visual): the plugin keeps the current cycle type in a local
-- variable with no exported getter, so we feed the key once to let the
-- plugin's own visual mapping handle it. After the first press that mapping
-- takes over and this wrapper is no longer used.
vim.keymap.set("v", "<leader>ca", function()
	ensure_qfr()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<leader>ca", true, true, true), "m", false)
end, { desc = "Review: add (current type)" })

-- Type cycling --------------------------------------------------------------
vim.keymap.set("n", "<M-+>", function()
	ensure_qfr().cycle_next_comment_type()
end, { desc = "Review: cycle next type" })

vim.keymap.set("n", "<M-->", function()
	ensure_qfr().cycle_previous_comment_type()
end, { desc = "Review: cycle previous type" })

-- Delete --------------------------------------------------------------------
vim.keymap.set("n", "<leader>cd", function()
	ensure_qfr().delete_comment()
end, { desc = "Review: delete at cursor" })

vim.keymap.set("v", "<leader>cd", function()
	ensure_qfr().delete_comment_visual()
end, { desc = "Review: delete at cursor" })

-- Export / clear / summary / save / load ------------------------------------
vim.keymap.set("n", "<leader>ce", function()
	ensure_qfr().export_review()
end, { desc = "Review: export → clipboard" })

vim.keymap.set("n", "<leader>cc", function()
	ensure_qfr().clear_review()
end, { desc = "Review: clear all (use between phases)" })

vim.keymap.set("n", "<leader>cS", function()
	ensure_qfr().summary()
end, { desc = "Review: summary" })

vim.keymap.set("n", "<leader>cw", function()
	ensure_qfr().save_review()
end, { desc = "Review: save" })

vim.keymap.set("n", "<leader>crr", function()
	ensure_qfr().load_review()
end, { desc = "Review: load" })

-- Navigation / view ---------------------------------------------------------
vim.keymap.set("n", "<leader>co", function()
	ensure_qfr()
	vim.cmd("copen")
end, { desc = "Review: open quickfix list" })

vim.keymap.set("n", "<leader>cg", function()
	ensure_qfr().goto_real_file()
end, { desc = "Review: goto file from diff" })

vim.keymap.set("n", "<leader>cv", function()
	ensure_qfr().view_comment()
end, { desc = "Review: view comment" })

vim.keymap.set("n", "]r", function()
	ensure_qfr()
	vim.cmd("cnext")
end, { desc = "Review: next comment" })

vim.keymap.set("n", "[r", function()
	ensure_qfr()
	vim.cmd("cprev")
end, { desc = "Review: previous comment" })

-- vim: ts=2 sts=2 sw=2 et
