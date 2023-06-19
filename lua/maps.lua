-- <leader> = the space key

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

local t_status, telescope = pcall(require, "telescope.builtin")

if t_status then
	map("n", "<C-p>", telescope.find_files)
end

-- Save
map("n", "<C-s>", "<CMD>update<CR>")

-- Quit
map("n", "<C-q>", "<CMD>q<CR>")

-- Lines
map("n", "<A-k>", ":m .-2<CR>")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("n", "<A-j>", ":m .+1<CR>")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Exit insert mode
map("i", "kj", "<ESC>")

-- Windows
map("n", "<leader>v", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>")
map("n", "<leader>o", "<CMD>Neotree focus<CR>")

-- Buffer
map("n", "<TAB>", "<CMD>bnext<CR>")
map("n", "<S-TAB>", "<CMD>bprevious<CR>")

-- Terminal
map({ "n", "i" }, "<C-t>", "<CMD>ToggleTerm size=10 direction=horizontal<CR>")
map("t", "<C-t>", "<CMD>ToggleTerm<CR>")
-- map("n", "<leader>tv", "<CMD>ToggleTerm size=80 direction=vertical<CR>")
-- map("t", "<esc>", "<C-\\><C-n>")

-- Markdown Preview
map("n", "<leader>m", "<CMD>MarkdownPreview<CR>")
map("n", "<leader>mn", "<CMD>MarkdownPreviewStop<CR>")

-- Window Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- Resize Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")
