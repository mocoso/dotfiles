SOURCE_DOTFILES := $(wildcard $(CURDIR)/home/.??*)
DOTFILES := $(notdir $(SOURCE_DOTFILES))
SYMLINKS := $(addprefix $(HOME)/, $(DOTFILES))

all: $(SYMLINKS)

$(SYMLINKS): $(HOME)/.%: $(CURDIR)/home/.%
	ln -is $< $@

list: # List the dotfiles
	@echo $(DOTFILES)

.PHONY: all list clean

clean:
	rm $(SYMLINKS)

