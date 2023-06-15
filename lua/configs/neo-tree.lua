
local status, neotree = pcall(require, "neo-tree")

if not status then
	return
end

neotree.setup({
  filesystem = {
    follow_current_file = true,
  }
})
