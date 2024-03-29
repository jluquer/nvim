-- [[ Basic Keymaps ]]
local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end
-- Keymaps for better default experience
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Save or quit
map({ "n", "i" }, "<C-s>", "<CMD>update<CR>")
map({ "n" }, "<leader>ww", ":wqa<CR>", { desc = "Close all and save" })
map({ "n" }, "<leader>wa", ":wqa<CR>", { desc = "Close all without saving" })

-- Lines
map("n", "<A-k>", ":m .-2<CR>")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")
map("n", "<A-j>", ":m .+1<CR>")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Window Navigation
map({ "n", "i" }, "<C-h>", "<C-w>h")
map({ "n", "i" }, "<C-l>", "<C-w>l")
map({ "n", "i" }, "<C-k>", "<C-w>k")
map({ "n", "i" }, "<C-j>", "<C-w>j")
map({ "t" }, ";;", "<C-\\><C-n>")
map({ "t" }, "<C-j>", "<C-\\><C-n><C-w>j")
map({ "t" }, "<C-k>", "<C-\\><C-n><C-w>k")
map({ "t" }, "<C-l>", "<C-\\><C-n><C-w>l")
map({ "t" }, "<C-h>", "<C-\\><C-n><C-w>h")

-- Resize Windows
map("n", "<A-Left>", "<C-w><")
map("n", "<A-Right>", "<C-w>>")
map("n", "<A-Up>", "<C-w>+")
map("n", "<A-Down>", "<C-w>-")

-- Tab navigation
map("n", "<Tab>", ":tabnext<CR>")
map("n", "<S-Tab>", ":tabprevious<CR>")
map("n", "<leader>q", ":q<CR>")

-- disable netrw at start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
