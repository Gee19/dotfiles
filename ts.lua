require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
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
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'vim' },
    max_file_lines = 10000,
  },
  indent = { enable = false },
  incremental_selection = { enable = false },
  textobjects = { enable = true },
    rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = 5000, -- Do not enable for files with more than n lines, int
  }
}

require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}
