SOURCE_FILE="./config.norg"
QUERY_FILE="./build/query.scm"
FENNEL_FILE="./build/config.fnl"
# FENNEL_FILE="./config.fnl"
LUA_FILE="./build/config.lua"
INSTALL_DIR="$(XDG_CONFIG_HOME)/nvim/lua"
INSTALL_FILE="$(INSTALL_DIR)/config.lua"
INIT_FILE="./init.lua"
PACKER_DIR="$(XDG_DATA_HOME)/nvim/site/pack/packer/start/packer.nvim"

all: packer build_dir query extract compile install init update

build_dir:
	mkdir -p ./build

query: build_dir
	echo "(ranged_tag (tag_name) @name (ranged_tag_content) @code (#eq? @name \"code\"))" > $(QUERY_FILE)

extract: query
	bash ./extract.sh
	# tree-sitter query --captures $(QUERY_FILE) $(SOURCE_FILE) | /usr/bin/env sed "s/    pattern:\s*\w*, capture:\s*\w*\s*-\s*name, start:\s*(\w*,\s*\w*),\s*end:\s(\w*,\s*\w*),\s*text:\s\`code\`//" | /usr/bin/env sed "s/    pattern:\s*\w*, capture:\s*\w*\s*-\s*code, start:\s*(\w*,\s*\w*),\s*end:\s(\w*,\s*\w*),\s*text:\s/---\n/" | awk '{ if (NR!=1) { print substr($$0, 3, length($$0)-5) } }' RS="---" > $(FENNEL_FILE)

compile: extract
	fennel --compile $(FENNEL_FILE) > $(LUA_FILE)

install: compile
	mkdir -p $(INSTALL_DIR)
	cp $(LUA_FILE) $(INSTALL_FILE)

init:
	echo "require('config')" > $(INIT_FILE)

update:
	nvim --headless +PackerCompile +qa

clean:
	rm -rf build

packer:
	if [ ! -d $(PACKER_DIR) ]; then git clone --depth 1 https://github.com/wbthomason/packer.nvim $(PACKER_DIR); fi

.PHONY: build_dir query clean

