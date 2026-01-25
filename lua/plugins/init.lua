return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    { "github/copilot.vim" },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndoTreeToggle)
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {}
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },
}
