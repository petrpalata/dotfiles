vim.diagnostic.config({
    virtual_text = {
        prefix = '■',
    },
    severity_sort = true,
    float = {
        source = "always",
    },
})

vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
