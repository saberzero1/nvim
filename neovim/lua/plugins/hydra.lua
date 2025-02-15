---@type LazySpec
return {
  'nvimtools/hydra.nvim',
  depends = {
    'folke/which-key.nvim',
    'folke/snacks.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'akinsho/bufferline.nvim',
    'folke/todo-comments.nvim',
    'gbprod/yanky.nvim',
  },
  config = function()
    local enable = false

    if not enable then
      return
    end
    -- External keymaps
    -- diagnostic
    local diagnostic_goto = function(next, severity)
      local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
      severity = severity and vim.diagnostic.severity[severity] or nil
      return function()
        go { severity = severity }
      end
    end
    -- Git Signs
    local gs = package.loaded.gitsigns
    -- Initialize the plugin
    local Hydra = require 'hydra'
    local util = require 'hydra.statusline'
    -- local Layer = require 'hydra.layer'
    Hydra.setup {
      color = 'red',
    }

    -- Set up layers
    local m = { 'n', 'x' } -- modes
    -- Set up heads
    Hydra {
      name = 'Hydra Jumper',
      mode = m,
      hint = [[ Jumper Hydra ]],
      body = '[',
      config = {
        hint = false,
        invoke_on_body = true,
      },
      heads = {
        -- a
        -- A
        -- c
        -- C
        -- f
        -- F
        {
          'h',
          function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              gs.nav_hunk 'prev'
            end
          end,
          { private = true, desc = 'Prev Hunk' },
        },

        {
          'H',
          function()
            gs.nav_hunk 'first'
          end,
          { private = true, desc = 'First Hunk' },
        },
        {
          '[',
          function()
            Snacks.words.jump(-vim.v.count1)
          end,
          { private = true, desc = 'Prev Reference' },
        },
        { 'b', '<cmd>BufferLineCyclePrev<cr>', { private = true, desc = 'Prev Buffer' } },
        { 'B', '<cmd>BufferLineMovePrev<cr>', { private = true, desc = 'Move buffer prev' } },
        { 'd', diagnostic_goto(false), { private = true, desc = 'Prev Diagnostic' } },
        { 'e', diagnostic_goto(false, 'ERROR'), { private = true, desc = 'Prev Error' } },
        -- m
        -- M
        { 'p', '<Plug>(YankyPutIndentBeforeLinewise)', { private = true, desc = 'Put Indented Before Cursor (Linewise)' } },
        { 'P', '<Plug>(YankyPutIndentBeforeLinewise)', { private = true, desc = 'Put Indented Before Cursor (Linewise)' } },
        { 'q', vim.cmd.cprev, { private = true, desc = 'Previous Quickfix' } },
        -- s
        {
          't',
          function()
            require('todo-comments').jump_prev()
          end,
          { private = true, desc = 'Previous Todo Comment' },
        },
        { 'w', diagnostic_goto(false, 'WARN'), { private = true, desc = 'Prev Warning' } },
        { 'y', '<Plug>(YankyCycleForward)', { private = true, desc = 'Cycle Forward Through Yank History' } },
        { '%', '[%', { private = true, desc = 'Previous unmatched group' } },
        { '{', '[{', { private = true, desc = 'Previous {' } },
        { '(', '[(', { private = true, desc = 'Previous (' } },
        { '<', '[<', { private = true, desc = 'Previous <' } },
      },
    }
    Hydra {
      name = 'Hydra Jumper',
      mode = m,
      hint = [[ Jumper Hydra ]],
      body = ']',
      config = {
        hint = false,
        invoke_on_body = true,
      },
      heads = {
        -- a
        -- A
        -- c
        -- C
        -- f
        -- F
        {
          'h',
          function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              gs.nav_hunk 'next'
            end
          end,
          { private = true, desc = 'Next Hunk' },
        },
        {
          'H',
          function()
            gs.nav_hunk 'last'
          end,
          { private = true, desc = 'Last Hunk' },
        },
        {
          ']',
          function()
            Snacks.words.jump(vim.v.count1)
          end,
          { private = true, desc = 'Next Reference' },
        },
        { 'b', '<cmd>BufferLineCycleNext<cr>', { private = true, desc = 'Next Buffer' } },
        { 'B', '<cmd>BufferLineMoveNext<cr>', { private = true, desc = 'Move buffer next' } },
        { 'd', diagnostic_goto(true), { private = true, desc = 'Next Diagnostic' } },
        { 'e', diagnostic_goto(true, 'ERROR'), { private = true, desc = 'Next Error' } },
        -- m
        -- M
        { 'p', '<Plug>(YankyPutIndentAfterLinewise)', { private = true, desc = 'Put Indented After Cursor (Linewise)' } },
        { 'P', '<Plug>(YankyPutIndentAfterLinewise)', { private = true, desc = 'Put Indented After Cursor (Linewise)' } },
        { 'q', vim.cmd.cnext, { private = true, desc = 'Next Quickfix' } },
        -- s
        {
          't',
          function()
            require('todo-comments').jump_next()
          end,
          { private = true, desc = 'Next Todo Comment' },
        },
        { 'w', diagnostic_goto(true, 'WARN'), { private = true, desc = 'Next Warning' } },
        { 'y', '<Plug>(YankyCycleBackward)', { private = true, desc = 'Cycle Backward Through Yank History' } },
        { '%', ']%', { private = true, desc = 'Next unmatched group' } },
        { '}', ']}', { private = true, desc = 'Next {' } },
        { ')', '])', { private = true, desc = 'Next (' } },
        { '>', ']>', { private = true, desc = 'Next <' } },
      },
    }
  end,
}
