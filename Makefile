## Rice installation

RICE_ROOT := $(abspath $(CURDIR))

all: .PHONY
.PHONY: bash git tmux gnupg

## Begin bash

BASHRC_FILE := $(HOME)/.bashrc

export define bashrc :=
source $(RICE_ROOT)/init.bash
update-gpg-agent
endef

bash:
	@echo Configuring bash config...
	@echo "$$bashrc" >>$(HOME)/.bashrc

## End bash

## Begin git

GITCONFIG_FILE := $(HOME)/.gitconfig

export define git_conf :=
[include]
path = $(RICE_ROOT)/config/.gitconfig
endef

git:
	@echo Configuring git config...
	@echo "$$git_conf" >$(HOME)/.gitconfig

## End git

## Begin tmux

TMUX_CONF_FILE := $(HOME)/.tmux.conf

export define tmux_conf :=
source $(RICE_ROOT)/config/.tmux.conf 
endef

tmux:
	@echo Configuring tmux config...
	@echo "$$tmux_conf" >$(HOME)/.tmux.conf

## End tmux

## Begin gnupg

GNUPG_DIR := $(HOME)/.gnupg/gpg-agent.conf

GPG_AGENT_CONF_FILE := $(GNUPG_DIR)/gpg-agent.conf

export define gpg_agent_conf :=
enable-ssh-support
allow-emacs-pinentry
pinentry-program /usr/bin/pinentry
default-cache-ttl 600
default-cache-ttl-ssh 600
max-cache-ttl 1800
max-cache-ttl-ssh 1800
endef

SSHCONTROL_FILE := $(GNUPG_DIR)/sshcontrol

export define sshcontrol :=
954DD3DC90FC80A52D76A0F1FF3C0EBCC35DA8CB
endef

gnupg:
	@echo Configuring gpg config...
	@echo "$$gpg_agent_conf" >$(HOME)/.gnupg/gpg-agent.conf
	@echo "$$sshcontrol" >$(HOME)/.gnupg/sshcontrol

## End gnupg
