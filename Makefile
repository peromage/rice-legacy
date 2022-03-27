## Rice installation

RICE_ROOT := $(abspath $(CURDIR))

## Begin variables

export define bashrc :=
source $(RICE_ROOT)/init.bash
update-gpg-agent
endef

export define git_conf :=
[include]
path = $(RICE_ROOT)/config/.gitconfig
endef

export define tmux_conf :=
source $(RICE_ROOT)/config/.tmux.conf 
endef

export define gpg_agent_conf :=
enable-ssh-support
allow-emacs-pinentry
pinentry-program /usr/bin/pinentry
default-cache-ttl 600
default-cache-ttl-ssh 600
max-cache-ttl 1800
max-cache-ttl-ssh 1800
endef

export define sshcontrol :=
954DD3DC90FC80A52D76A0F1FF3C0EBCC35DA8CB
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
	@echo "$$git_conf" >$(HOME)/.gitconfig

tmux:
	@echo Configuring tmux config...
	@echo "$$tmux_conf" >$(HOME)/.tmux.conf

gpg:
	@echo Configuring gpg config...
	@echo "$$gpg_agent_conf" >$(HOME)/.gnupg/gpg-agent.conf
	@echo "$$sshcontrol" >$(HOME)/.gnupg/sshcontrol

## End recipes
