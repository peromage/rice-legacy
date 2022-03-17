## Rice installation

RICE_ROOT := $(abspath $(CURDIR))

## Begin variables

export define bashrc :=
source $(RICE_ROOT)/init.bash
update-gpg-agent
endef

export define gitconf :=
[include]
path = $(RICE_ROOT)/config/.gitconfig
endef

export define tmuxconf :=
source $(RICE_ROOT)/config/.tmux.conf 
endef

export define gpgconf :=
enable-ssh-support
allow-emacs-pinentry
pinentry-program /usr/bin/pinentry
endef

export define sshcontrol :=
904C369CCEB586593AE642BB17AAC50C01213056
endef

## End variables

## Begin recipes

all: .PHONY

.PHONY: bash git tmux gpg

bash:
	@echo Configuring bash config...
	@echo "$$bashrc" >>$(HOME)/.bashrc

git:
	@echo Configuring git config...
	@echo "$$gitconf" >$(HOME)/.gitconfig

tmux:
	@echo Configuring tmux config...
	@echo "$$tmuxconf" >$(HOME)/.tmux.conf

gpg:
	@echo Configuring gpg config...
	@echo "$$gpgconf" >$(HOME)/.gnupg/gpg-agent.conf
	@echo "$$sshcontrol" >$(HOME)/.gnupg/sshcontrol

## End recipes
