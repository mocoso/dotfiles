SOURCE_DOTFILES := $(wildcard $(CURDIR)/home/.??*)
DOTFILES := $(notdir $(SOURCE_DOTFILES))
OS := $(shell uname)
SYMLINKS := $(addprefix $(HOME)/, $(DOTFILES))


all: install

dotfiles: $(SYMLINKS)

download_git_submodules:
	git submodule init && git submodule update

$(SYMLINKS): $(HOME)/.%: $(CURDIR)/home/.%
	ln -is $< $@

list_dotfiles:
	@echo $(DOTFILES)

ifeq ($(OS),Darwin)
OSX_BREW_BIN_DIR := /usr/local/bin
OSX_BREW_INSTALL := ctags git ruby-install fish reattach-to-user-namespace tmux \
	tree vim ssh-copy-id
OSX_BREW_INSTALL_BINARIES = $(addprefix $(OSX_BREW_BIN_DIR)/, $(OSX_BREW_INSTALL))
OSX_BREW_BINARY = $(addprefix $(OSX_BREW_BIN_DIR)/, brew)

define exit_with_instructions
  @(echo "\n$(1)\n" && false);
endef

$(OSX_BREW_INSTALL_BINARIES): | $(OSX_BREW_BINARY)
	brew install $(notdir $@)

$(OSX_BREW_BINARY):
	$(call exit_with_instructions, 'Install homebrew from http://mxcl.github.com/homebrew/')

osx_bootstrap:
	./osx_bootstrap.sh

# Configure homebrew permissions to allow multiple users on MAC OSX.
# Any user from the brew  group will be able to manage the homebrew and cask installation on the machine.
fix_brew_permissions:
	for d in /usr/local/*/; do sudo chgrp -R brew $$d && sudo chmod -R g+w $$d; done

else
OSX_BREW_INSTALL_BINARIES :=

osx_bootstrap:
fix_brew_permissions:
endif

fish_completions:
	fish -c fish_update_completions

install_vim_plugins:
	vim -c "call minpac#update()" -c ":q"

install: $(OSX_BREW_INSTALL_BINARIES) download_git_submodules dotfiles \
	install_vim_plugins fish_completions osx_bootstrap
	
.PHONY: all dotfiles list_dotfiles download_git_submodules install \
	fix_brew_permissions install_vim_plugins clean

clean:
	rm $(SYMLINKS)
