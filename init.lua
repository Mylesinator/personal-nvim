require("mylesinator")
require("config.lazy")

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

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
