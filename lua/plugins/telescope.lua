return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [Files]" })
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch using [G]rep" })
        vim.keymap.set("n", ",leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    end
}
