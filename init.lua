require("mylesinator")
require("config.lazy")
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {'lua_ls', 'rust_analyzer', 'emmet_language_server'},
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope git files' })
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)


local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        -- Simple tab complete
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item({behavior = 'select'})
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, {'i', 's'}),


        ['<Enter>'] = cmp.mapping.confirm({select = true}),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    }),

    sources = {
        {name = 'nvim_lsp'},
        {name = 'buffer'},
    },
})
