local theme = {
  fill = "TabLineFill",
  head = "TabLine",
  current_tab = "TabLineSel",
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}

local open_tabs = {}

local tab_name = function(tab)
  local api = require "tabby.module.api"
  local cur_win = api.get_tab_current_win(tab.id)
  if api.is_float_win(cur_win) then
    return "[Floating]"
  end
  local current_bufnr = vim.fn.getwininfo(cur_win)[1].bufnr
  local current_bufinfo = vim.fn.getbufinfo(current_bufnr)[1]
  local current_buf_name = vim.fn.fnamemodify(current_bufinfo.name, ":t")
  -- local no_extension = vim.fn.fnamemodify(current_bufinfo.name, ":p:r")

  if string.find(current_buf_name, "NvimTree") ~= nil then
    return "[File Explorer]"
  end

  if current_buf_name == "NeogitStatus" then
    return "[Neogit]"
  end

  if open_tabs[current_bufinfo.name] == nil then
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    open_tabs[current_bufinfo.name] = project_name
  end

  if current_buf_name == "" then
    return "[Empty]"
  else
    if open_tabs[current_bufinfo.name] == nil then
      return current_buf_name
    end

    return open_tabs[current_bufinfo.name] .. ":" .. current_buf_name
  end
end

local tab_count = function()
  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    return tabpage_number .. "/" .. tostring(num_tabs)
  end
end

return {
  "nanozuki/tabby.nvim",
  event = "VeryLazy",
  config = function()
    require("tabby.tabline").set(function(line)
      return {
        {
          { " 󰓩  ", hl = theme.head },
          { tab_count(), hl = theme.head },
          -- line.sep(" ", theme.head, theme.fill),
          line.sep(" ", theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            -- line.sep("", hl, theme.fill),
            line.sep("", hl, theme.fill),
            tab.is_current() and "" or "",
            tab_name(tab),
            tab.close_btn "󰅖 ",
            -- window_count(tab),
            -- change_mark(tab),
            -- line.sep(" ", hl, theme.fill),
            line.sep(" ", hl, theme.fill),
            hl = hl,
            margin = " ",
          }
        end),
        hl = theme.fill,
      }
    end, {
      buf_name = {
        mode = "unique",
      },
    })
  end,
  keys = {
    { "<leader>ta",  ":$tabnew<CR>",  desc = "Add tab" },
    { "<leader>tc",  ":tabclose<CR>", desc = "Close tab" },
    { "<leader>tn",  ":tabn<CR>",     desc = "Next tab" },
    { "<leader>tp",  ":tabp<CR>",     desc = "Previous tab" },
    { "<leader>tmp", ":-tabmove<CR>" },
    { "<leader>tmn", ":+tabmove<CR>" },
  },
}
