import os

# Linux - create "Default (Linux).sublime-mousemap" in ~/.config/sublime-text-3/Packages/User
# Mac - create "Default (OSX).sublime-mousemap" in ~/Library/Application Support/Sublime Text 3/Packages/User
# Win - create "Default (Windows).sublime-mousemap" in %appdata%\Sublime Text 3\Packages\User

# Settings file - Preferences.sublime-settings

# Kitty: ln -s /Users/jhaine/dev/dotfiles/kitty.conf /Users/jhaine/.config/kitty/kitty.conf
# Neovim: ln -s /Users/jhaine/dev/dotfiles/init.vim /Users/jhaine/.config/nvim/init.vim
exclude = [
    'README',
    'config.cson',
    'packages.list',
    'hosts',
    'osxdefaults',
    'nginx.conf',
    'install.py',
    'iterm_profile',
    'Default (OSX).sublime-mousemap',
    'Default (Windows).sublime-mousemap',
    'Preferences.sublime-settings',
    'Package Control.sublime-settings',
    'wage.code-workspace',
    'sde.code-workspace',
    'sde_settings.json',
    'sdetools_settings.json',
    'settings.json',
    'coc-settings.json',
    'kitty.conf',
    'init.vim'
]

home = os.path.expanduser('~')
here = os.path.abspath('.')

# symlink all the files in this repo in the home directory
for f in os.listdir('.'):
    if f in exclude or f[0] == '.':
        continue

    local_file = "%s/%s" % (here, f)
    install_file = "%s/.%s" % (home, f)
    if os.path.exists(install_file):
        continue

    cmd = 'ln -sf %s %s' % (local_file, install_file)

    print cmd

    os.system(cmd)
