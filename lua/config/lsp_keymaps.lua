local on_attach = function(_, bufnr)
  local bind = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  bind('<leader>rn', vim.lsp.buf.rename, 'LSP: [R]e[n]ame')
  bind('<leader>ca', vim.lsp.buf.code_action, 'LSP: [C]ode [A]ction')

  bind('gd', require('telescope.builtin').lsp_definitions, 'LSP: [G]oto [D]efinition')
  bind('gr', require('telescope.builtin').lsp_references, 'LSP: [G]oto [R]eferences')
  bind('gI', require('telescope.builtin').lsp_implementations, 'LSP: [G]oto [I]mplementation')
  bind('<leader>D', require('telescope.builtin').lsp_type_definitions, 'LSP: Type [D]efinition')
  bind('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'LSP: [D]ocument [S]ymbols')
  bind('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'LSP: [W]orkspace [S]ymbols')
  bind('K', vim.lsp.buf.hover, 'LSP: Hover Documentation')
  bind('<C-k>', vim.lsp.buf.signature_help, 'LSP: Signature Documentation')
  bind('gD', vim.lsp.buf.declaration, 'LSP: [G]oto [D]eclaration')
  bind('<leader>wa', vim.lsp.buf.add_workspace_folder, 'LSP: [W]orkspace [A]dd Folder')
  bind('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'LSP: [W]orkspace [R]emove Folder')
  bind('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'LSP: [W]orkspace [L]ist Folders')
end

return on_attach
