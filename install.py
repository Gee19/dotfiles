import os

include = {
    # Editors
    'init.vim': '$XDG_CONFIG_HOME/nvim/init.vim',
    'vimrc': '$HOME/.vimrc',

    # Git
    'gitconfig': '$HOME/.gitconfig',
    'gitignore_global': '$HOME/.gitignore_global',
    'stCommitMsg': '$HOME/.stCommitMsg',

    # ripgrep
    'ripgreprc': '$XDG_CONFIG_HOME/.ripgreprc',

    # pdb
    'pdbrc': '$HOME/.pdbrc',

    # pdb++
    'pdbrc.py': '$HOME/.pdbrc.py',

    #Tmux
    'tmux.conf': '$HOME/.tmux.conf',

    # Terminal
    # 'kitty.conf': '$HOME/.config/kitty/kitty.conf',
    # 'diff.conf': '$HOME/.config/kitty/diff.conf',

    # Shell
    'bashrc': '$HOME/.bashrc',
    'aliases': '$HOME/.aliases',

    'zshenv': '$HOME/.zshenv',
    'zshrc': '$HOME/.zshrc'
}

# home = os.path.expanduser('~')
here = os.path.abspath('.')

cmds = []
for f, install_path in include.items():
    local_file = "%s/%s" % (here, f)

    if isinstance(install_path, list):
        for path in install_path:
            cmds.append('ln -sf %s %s' % (local_file, path))
    else:
        cmds.append('ln -sf %s %s' % (local_file, install_path))

for cmd in cmds:
    print(cmd)
    os.system(cmd)
