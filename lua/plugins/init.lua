return {
    { "folke/neodev.nvim" },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    { "github/copilot.vim" },
    { "mbbill/undotree", },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "numToStr/Comment.nvim", opts = {} },
    { "tpope/vim-fugitive" },
}
