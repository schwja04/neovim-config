return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()

            local config = require("nvim-treesitter.configs")
            config.setup({
                ensure_installed = {
                    "bash",
                    "c_sharp",
                    "css",
                    "gitignore",
                    "html",
                    "ini",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "mermaid",
                    "python",
                    "sql",
                    "ssh_config",
                    "tsx",
                    "typescript",
                    "xml",
                    "yaml"
                },
                auto_install = true,
                highlight = {
                    additional_vim_regex_highlighting = false,
                    enable = true,
                },
                intent = { enable = true },
                sync_install = false,
            })

            -- treesitter-context configuration
            vim.keymap.set("n", "[c", function()
              require("treesitter-context").go_to_context()
            end, { silent = true })
        end
    },
    { "nvim-treesitter/nvim-treesitter-context" },
}
