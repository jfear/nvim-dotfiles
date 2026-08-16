vim.pack.add {
  { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range '2.*' },
  'https://github.com/rafamadriz/friendly-snippets',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
}

require('luasnip').setup {}
require('luasnip.loaders.from_vscode').lazy_load()

require('blink.cmp').setup {
  keymap = { preset = 'super-tab' },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    list = { selection = { preselect = true, auto_insert = false } },
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
    trigger = {
      show_on_accept_on_trigger_character = true,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets' },
    providers = {
      path = {
        opts = {
          trailing_slash = true,
          label_trailing_slash = true,
          show_hidden_files_by_default = false,
        },
      },
    },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  signature = { enabled = true },
}
