local status, toggleterm = pcall(require, "toggleterm")

if not status then
	return
end

local shell = vim.fn.has("unix") == 0 and "pwsh.exe" or vim.o.shell

toggleterm.setup({
	size = 10,
	open_mapping = [[<A-i>]],
	shading_factor = 2,
	direction = "float",
	shell = shell,
	float_opts = {
		border = "curved",
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end
