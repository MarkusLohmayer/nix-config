local M = {
  "lewis6991/gitsigns.nvim",
  commit = "ec4742a7eebf68bec663041d359b95637242b5c3",
  event = "BufReadPre",
}

M.opts = {
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  signcolumn = true,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "previous hunk" })

    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true, desc = "next hunk" })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, {desc = "stage hunk"})
    map("n", "<leader>hr", gs.reset_hunk, {desc = "reset hunk"})
    map("v", "<leader>hs", function()
      gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, {desc = "stage hunk"})
    map("v", "<leader>hr", function()
      gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, {desc = "reset hunk"})
    map("n", "<leader>hS", gs.stage_buffer, {desc = "stage buffer"})
    map("n", "<leader>hu", gs.undo_stage_hunk, {desc = "undo stage hunk"})
    map("n", "<leader>hR", gs.reset_buffer, {desc = "reset buffer"})
    map("n", "<leader>hp", gs.preview_hunk, {desc = "preview hunk"})
    map("n", "<leader>hb", function()
      gs.blame_line { full = true }
    end, {desc = "blame"})
    map("n", "<leader>tb", gs.toggle_current_line_blame, {desc = "blame"})
    map("n", "<leader>hd", gs.diffthis, {desc = "diff this"})
    map("n", "<leader>hD", function()
      gs.diffthis "~"
    end, { desc = "diff" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "toggle deleted" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {desc = "hunk"})
  end,
}

return M
