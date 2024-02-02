return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    local wk = require('which-key')
    -- document existing key chains
    wk.register({
      ['b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
      ['d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
      ['f'] = { name = '[F]ind', _ = 'which_key_ignore' },
      ['g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
      ['l'] = { name = '[L]SP and LazyApps', _ = 'which_key_ignore' },
      ['q'] = { name = '[Q]uit & Session', _ = 'which_key_ignore' },
      ['r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['t'] = { name = '[T]erminal & Tabs', _ = 'which_key_ignore', m = 'Move tab' },
      ['w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    }, { prefix = '<leader>' })
    -- register which-key VISUAL mode
    -- required for visual <leader>hs (hunk stage) to work
    wk.register({
      ['<leader>'] = { name = 'VISUAL <leader>' },
      ['<leader>h'] = { 'Git [H]unk' },
    }, { mode = 'v' })
  end,
  opts = {}
}
