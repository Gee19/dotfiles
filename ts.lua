require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  ensure_installed = {
    'javascript',
    'typescript',
    'vim',
    'yaml',
    'regex',
    'toml',
    'lua',
    'css',
    'scss',
    'json',
    'c_sharp',
    'bash',
    'elixir',
    'python',
    'dockerfile',
    'go',
    'html',
    'cmake'
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}
