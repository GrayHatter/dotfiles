:lua << EOF
    local lspconfig = require('lspconfig')
    local on_attach = function(_, bufnr)
        vim.diagnostic.config({
          float = false,
          virtual_text = true,
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        })
        vim.o.updatetime = 2500

        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', '<space>D', function() vim.lsp.buf.type_definition { reuse_win = true } end, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = false } end, bufopts)
        --require('completion').on_attach()
        vim.diagnostic.setloclist({open=false})
    end

    local servers = {'zls'}
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
        }
    end
EOF
