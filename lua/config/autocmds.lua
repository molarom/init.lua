local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create autogroup.
local molaromAG = augroup('molarom', { clear = true })

-- autocmd('TextYankPost', {
--   callback = function()
--     require("vim.highlight").on_yank({ higroup = "YankHighlight", timeout = 200 })
--   end,
--   group = molaromAG,
--   desc = "Highlight when yanking",
--   pattern = '*',
-- })

autocmd({ "VimEnter" }, { 
  callback = function()
    local ok, _ = pcall(require, "nvim-tree")
    if(not ok) then
      vim.print("Nvim-Tree is not installed or setup correctly.")
    else
      require("nvim-tree.api").tree.open()
    end
  end,
  group = molaromAG,
  desc = "Open Nvim-Tree when vim opens.",
})

autocmd("VimResized", {
  callback = function()
    vim.cmd "wincmd ="
  end,
  group = molaromAG,
  desc = "Equalize Splits",
})

autocmd("TermOpen", {
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.cmd "startinsert!"
  end,
  group = molaromAG,
  desc = "Terminal Options",
})


-- autocmd("WinClosed", {
--   callback = function ()
--     local winnr = tonumber(vim.fn.expand("<amatch>"))
--     vim.schedule_wrap(function (winnr)
--         local api = require"nvim-tree.api"
--         local tabnr = vim.api.nvim_win_get_tabpage(winnr)
--         local bufnr = vim.api.nvim_win_get_buf(winnr)
--         local buf_info = vim.fn.getbufinfo(bufnr)[1]
--         local tab_wins = vim.tbl_filter(function(w) return w~=winnr end, vim.api.nvim_tabpage_list_wins(tabnr))
--         local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
--         if buf_info.name:match(".*NvimTree_%d*$") then            -- close buffer was nvim tree
--           -- Close all nvim tree on :q
--           if not vim.tbl_isempty(tab_bufs) then                      -- and was not the last window (not closed automatically by code below)
--             api.tree.close()
--           end
--         else                                                      -- else closed buffer was normal buffer
--           if #tab_bufs == 1 then                                    -- if there is only 1 buffer left in the tab
--             local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
--             if last_buf_info.name:match(".*NvimTree_%d*$") then       -- and that buffer is nvim tree
--               vim.schedule(function ()
--                 if #vim.api.nvim_list_wins() == 1 then                -- if its the last buffer in vim
--                   vim.cmd "quit"                                        -- then close all of vim
--                 else                                                  -- else there are more tabs open
--                   vim.api.nvim_win_close(tab_wins[1], true)             -- then close only the tab
--                 end
--               end)
--             end
--           end
--         end
--       end
--     )
--   end,
--   nested = true,
--   group = molaromAG,
--   desc = "Close NvimTree if it's the last buffer.",
-- })
