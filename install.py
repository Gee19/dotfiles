import os

include = {
    # Editors
    "init.vim": "$XDG_CONFIG_HOME/nvim/init.vim",
    "ts.lua": "$XDG_CONFIG_HOME/nvim/lua/ts.lua",
    "vimrc": "$HOME/.vimrc",
    # Git
    "gitignore_global": "$HOME/.gitignore_global",
    "stCommitMsg": "$HOME/.stCommitMsg",
    "git-jump": "$HOME/.local/bin/git-jump",
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

# git
in_wsl = "WSL" in os.uname().release
relevant_gitconfig = "gitconfig" if not in_wsl else "gitconfig_home"
include[relevant_gitconfig] = "$HOME/.gitconfig"

if not in_wsl:
    include["kitty.conf"] = "$HOME/.config/kitty/kitty.conf"
    include["diff.conf"] = "$HOME/.config/kitty/diff.conf"

# home = os.path.expanduser('~')
here = os.path.abspath(".")

cmds = []
for f, install_path in include.items():
    local_file = "%s/%s" % (here, f)

    if isinstance(install_path, list):
        for path in install_path:
            cmds.append("ln -sf %s %s" % (local_file, path))
    else:
        cmds.append("ln -sf %s %s" % (local_file, install_path))

for cmd in cmds:
    print(cmd)
    os.system(cmd)
