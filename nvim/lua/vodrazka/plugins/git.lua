return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', '<leader>gn', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Next hunk" })

        map('n', '<leader>gp', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Previous hunk" })

        -- Actions
        map('n', '<leader>gg', gs.preview_hunk_inline, { desc = "Preview hunk inline" })
        map('n', '<leader>gt', gs.preview_hunk, { desc = "Preview hunk" })
        map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage hunk" })
        map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset hunk" })
        map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { desc = "Stage hunk" })
        map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { desc = "Reset hunk" })
        map('n', '<leader>gS', gs.stage_buffer, { desc = "Stage buffer" })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map('n', '<leader>gR', gs.reset_buffer, { desc = "Reset buffer" })
        map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = "Blame" })
        map('n', '<leader>gv', gs.toggle_current_line_blame, { desc = "Toggle blame" })
        map('n', '<leader>gdd', gs.diffthis, { desc = "Diff this" })
        map('n', '<leader>gdf', function() gs.diffthis('~') end, { desc = "Diff file" })
        map('n', '<leader>gdt', gs.toggle_deleted, { desc = "Toggle deleted" })
      end
    }
  end,
}
