local function configure_lsp()
    local lsp_attach_group = vim.api.nvim_create_augroup("JaLspAttach", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keybindings",
        group = lsp_attach_group,
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
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()


    require("mason").setup({})
    require("mason-lspconfig").setup({
        ensure_installed = {
            "csharp_ls",
            "gopls",
            "lua_ls",
            "pylsp",
            "ts_ls",
        },
        -- mason-lspconfig will otherwise call vim.lsp.enable() for installed
        -- servers (Neovim 0.11+), which can start a *second* lua_ls instance
        -- without our lspconfig settings.
        automatic_enable = false,
    })

    -- Your mason-lspconfig version doesn't support setup_handlers.
    -- Configure servers directly instead.
    lspconfig.csharp_ls.setup({
        capabilities = lsp_capabilities,
        cmd = { "csharp-ls" },
        filetypes = { "cs" },
        init_options = {
            AutomaticFormatOnSave = true,
            AutomaticWorkspaceInit = true,
        },
    })

    lspconfig.gopls.setup({
        capabilities = lsp_capabilities,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
            },
        },
    })

    lspconfig.lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })

    lspconfig.pylsp.setup({
        capabilities = lsp_capabilities,
    })

    lspconfig.ts_ls.setup({
        capabilities = lsp_capabilities,
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
            { "folke/neodev.nvim" },

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
        priority = 900,
        lazy = false,
        config = function()
            configure_lsp()
        end,
    },
}
