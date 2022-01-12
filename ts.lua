require'nvim-treesitter.configs'.setup {
  -- Modules and its options go here
  ensure_installed = {
    'javascript',
    'typescript',
    -- 'vim',
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
  indent = { enable = false },
  incremental_selection = { enable = false },
  textobjects = { enable = true },
    rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
