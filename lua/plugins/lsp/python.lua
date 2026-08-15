-- Python LSP configuration using Astral's `ty` for type checking and completions.
-- Requires: `uv tool install ty` (or `ty` available on $PATH)

vim.lsp.config('ty', {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    '.git',
  },
})

vim.lsp.enable('ty')
