return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    always_show = {
                        ".github/",
                        ".env",
                        ".gitignore",
                        ".air.toml",
                    },
                    never_show = {
                        ".git/",
                        "node_modules/",
                        ".cache/",
                        ".vscode/",
                        ".vs/",
                    },
                },
            },
            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function()
                        require("neo-tree.command").execute({ action = "close" })
                    end,
                },
            },
        })
        vim.keymap.set("n", "<leader>n", ":Neotree filesystem toggle left<CR>")
    end,
}
