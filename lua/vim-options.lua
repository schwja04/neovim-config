-- numbering
vim.opt.nu = true
vim.opt.relativenumber = true

-- timeout
vim.o.timeout = true
vim.o.timeoutlen = 300

-- tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- viewport
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- remove whitespace on save
local JaCodeGroup = vim.api.nvim_create_augroup("JaCodeGroup", {})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = JaCodeGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]]
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = JaCodeGroup,
    pattern = "*",
    callback = function()
        local ok, conform = pcall(require, "conform")
        if ok then
            conform.format({ lsp_fallback = true })
        else
            vim.lsp.buf.format()
        end
    end
})
