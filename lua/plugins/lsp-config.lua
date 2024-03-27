local function configure_lsp()
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keybindings",
        callback = function(event)
            local opts = { buffer = event.buf, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end,
    })

    local lspconfig = require("lspconfig")
    local lsp_capabitilies = require("cmp_nvim_lsp").default_capabilities()


    require("mason").setup({})
    require("mason-lspconfig").setup({
        ensure_installed = {
            "ansiblels",
            "bashls",
            "csharp_ls",
            "eslint",
            "lua_ls",
            "pylsp",
            "rust_analyzer",
            "tsserver"
        },
        handlers = {
            function(server)
                lspconfig[server].setup({
                    capabilities = lsp_capabitilies,
                })
            end,
            lua_ls = function()
                lspconfig.lua_ls.setup({
                    capabilities = lsp_capabitilies,
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workplaces = {
                                vim.env.VIMRUNTIME,
                            },
                        },
                    },
                })
            end,
        }
    })


    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        sources = {
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        }),
        window = {
            documentation = cmp.config.window.bordered(),
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- LSP Support
            { "williamboman/mason.nvim", },
            { "williamboman/mason-lspconfig.nvim", },

            -- Autocompletions
            { "hrsh7th/nvim-cmp", },
            { "hrsh7th/cmp-buffer", },
            { "hrsh7th/cmp-path", },
            { "saadparwaiz1/cmp_luasnip", },
            { "hrsh7th/cmp-nvim-lsp", },
            { "hrsh7th/cmp-nvim-lua", },

            -- Snippets
            {
                "L3MON4D3/LuaSnip",
                version = "v2.1.1",
            },
            { "rafamadriz/friendly-snippets", },
        },
        lazy_load = false,
        config = function()
            configure_lsp()
        end,
    },
}
