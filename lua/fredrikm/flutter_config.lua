vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("FlutterGroup", { clear = true }),
    pattern = "dart",
    callback = function()
        vim.keymap.set("n", "fs", ":FlutterRun<CR>")
        vim.keymap.set("n", "fr", ":FlutterRestart<CR>")
        vim.keymap.set("n", "fe", ":FlutterEmulators<CR>")
        vim.keymap.set("n", "fc", ":FlutterCopyProfilerUrl<CR>")
        vim.keymap.set("n", "fq", ":FlutterQuit<CR>")
        vim.keymap.set("n", "fpg", ":FlutterPubGet<CR>")
        -- vim.keymap.set({ "n" }, "fl", ":vnew | buffer __FLUTTER_DEV_LOG__<CR>", { remap = false, desc = "Open flutter dev log in vertical split" })
        vim.keymap.set("n", "fl", function()
            local buf = require("flutter-tools.log").buf
            if not buf then
                return print("Couldn't find buffer for dev log, ensure that the flutter project is running")
            end
            local current_win = vim.fn.winnr()
            local wins = vim.fn.getwininfo();
            for _, win in pairs(wins) do
                if win.bufnr == buf then
                    -- moves back to log window
                    vim.cmd.wincmd({ "w", count = win.winnr })
                    vim.cmd.quit()
                    -- moves back to original window
                    vim.cmd.wincmd({ "w", count = current_win })
                    return
                end
            end
            vim.cmd.vsplit()
            vim.api.nvim_set_current_buf(buf)
            vim.cmd.wincmd({ "w", count = current_win })
        end)
    end
    })
