SOURCE_DOTFILES := $(wildcard $(CURDIR)/home/.??*)
DOTFILES := $(notdir $(SOURCE_DOTFILES))
OS := $(shell uname)
SYMLINKS := $(addprefix $(HOME)/, $(DOTFILES))


all: install

dotfiles: $(SYMLINKS)

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
else
OSX_BREW_INSTALL_BINARIES :=

osx_bootstrap:
endif

install: $(OSX_BREW_INSTALL_BINARIES) dotfiles osx_bootstrap
	
.PHONY: all dotfiles list_dotfiles install clean

clean:
	rm $(SYMLINKS)

