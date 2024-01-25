local wk = require("which-key")

local status, telescope = pcall(require, "telescope.builtin")
if not status then
	print("Telescope not found")
	return
end

local leader_mappings = { prefix = "<leader>" }
wk.register({
	b = { "<cmd>Telescope buffers<cr>", "Active buffers" },
	f = {
		name = "File",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	},
	g = {
		name = "Git",
		c = { "<cmd>Telescope git_commits<cr>", "Commits" },
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		s = { "<cmd>Telescope git_status<cr>", "Status" },
	},
	h = {
		name = "Help",
		t = { "<cmd>Telescope<cr>", "Telescope" },
		h = { "<cmd>Telescope help_tags<cr>", "Telescope help tags" },
	},
	l = {
		name = "Code",
		c = { name = "Code action" },
		f = { name = "Format" },
		o = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols" },
	},
	s = {
		name = "Search",
		g = { "<cmd>Telescope live_grep<cr>", "Search in project" },
	},
}, leader_mappings)
