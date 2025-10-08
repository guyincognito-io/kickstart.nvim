return {
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    opts = function()
      local function on_attach(_, bufnr)
        local function map(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = bufnr, desc = 'TS: ' .. desc })
        end

        map('<leader>co', '<cmd>TSToolsOrganizeImports<CR>', 'Organize imports')
        map('<leader>cM', '<cmd>TSToolsAddMissingImports<CR>', 'Add missing imports')
        map('<leader>cU', '<cmd>TSToolsRemoveUnused<CR>', 'Remove unused statements')
        map('<leader>cR', '<cmd>TSToolsRenameFile<CR>', 'Rename file')
        map('gS', '<cmd>TSToolsGoToSourceDefinition<CR>', 'Go to source definition')
      end

      return {
        on_attach = on_attach,
        settings = {
          separate_diagnostic_server = true,
          publish_diagnostic_on = 'insert_leave',
          expose_as_code_action = 'all',
          tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      }
    end,
    config = function(_, opts)
      require('typescript-tools').setup(opts)
    end,
  },
}
