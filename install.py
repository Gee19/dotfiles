import os

include = {
    # Editors
    "init.vim": "$XDG_CONFIG_HOME/nvim/init.vim",
    "vimrc": "$HOME/.vimrc",
    # kitty
    "kitty.conf": "$HOME/.config/kitty/kitty.conf",
    # Git
    "gitconfig": "$HOME/.gitconfig",
    "gitignore_global": "$HOME/.gitignore_global",
    "git-jump": "$HOME/.local/bin/git-jump",
    # gpg
    "gpg-agent.conf": "$HOME/.gnupg/gpg-agent.conf",
    # coc.nvim
    "coc-settings.json": [
        "$XDG_CONFIG_HOME/nvim/coc-settings.json",
        "$HOME/.vim/coc-settings.json",
    ],
    # ripgrep
    "ripgreprc": "$XDG_CONFIG_HOME/.ripgreprc",
    # pdb
    "pdbrc": "$HOME/.pdbrc",
    # pdb++
    "pdbrc.py": "$HOME/.pdbrc.py",
    # Tmux
    "tmux.conf": "$HOME/.tmux.conf",
    # Shell
    "bashrc": "$HOME/.bashrc",
    "aliases": "$HOME/.aliases",
    "zshenv": "$HOME/.zshenv",
    "zshrc": "$HOME/.zshrc",
}

here = os.path.dirname(os.path.abspath(__file__))
cmds = []
for f, install_path in include.items():
    local_file = "%s/%s" % (here, f)

    paths = install_path if isinstance(install_path, list) else [install_path]
    for path in paths:
        parent = os.path.dirname(path)
        # gpg refuses to use a ~/.gnupg other users can read
        mode = "-m 700 " if parent.endswith(".gnupg") else ""
        cmds.append("mkdir -p %s%s" % (mode, parent))
        cmds.append("ln -sfn %s %s" % (local_file, path))

for cmd in cmds:
    print(cmd)
    os.system(cmd)
