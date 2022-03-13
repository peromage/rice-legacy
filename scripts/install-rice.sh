#!/usr/bin/bash

## Rice is assumed to be cloned at $HOME/.rice

read -p 'This will overwrite config files. Proceed anyway? (y/n) ' -r -n 1 \
    && [[ $REPLY =~ ^[nN]$ ]] \
    && echo \
    && exit 
echo

echo Configuring bash config...
cat <<EOF >>$HOME/.bashrc
source $HOME/.rice/init.bash
update-gpg-agent
EOF

echo Configuring git config...
cat <<EOF >$HOME/.gitconfig
[include]
path = ~/.rice/config/.gitconfig
EOF

echo Configuring tmux config...
cat <<EOF >$HOME/.tmux.conf
source ~/.rice/config/.tmux.conf 
EOF

echo Configuring gpg config...
cat <<EOF >$HOME/.gnupg/gpg-agent.conf
enable-ssh-support
allow-emacs-pinentry
pinentry-program /usr/bin/pinentry
EOF
cat <<EOF >$HOME/.gnupg/sshcontrol
904C369CCEB586593AE642BB17AAC50C01213056
EOF
