-- Reveals the vim undo tree for better undo-ing
return {
  'mbbill/undotree',
  enabled = true,
  keys = {
    {'<leader>ut', '<cmd> UndotreeToggle<CR>'},
  },
}
