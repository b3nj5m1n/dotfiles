SOURCE_FILE="./config.norg"
QUERY_FILE="./build/query.scm"
FENNEL_FILE="./build/config.fnl"
LUA_FILE="./build/config.lua"
INSTALL_FILE="$(XDG_CONFIG_HOME)/nvim/lua/config.lua"
INIT_FILE="./build/init.lua"

all: build_dir query extract compile install init

build_dir:
	mkdir -p ./build

query: build_dir
	echo "(ranged_tag (tag_name) @name (ranged_tag_content) @code (#eq? @name \"code\"))" > $(QUERY_FILE)

extract: query
	tree-sitter query --captures $(QUERY_FILE) $(SOURCE_FILE) | /bin/sed "s/    pattern:\s*\w*, capture:\s*\w*\s*-\s*name, start:\s*(\w*,\s*\w*),\s*end:\s(\w*,\s*\w*),\s*text:\s\`code\`//" | /bin/sed "s/    pattern:\s*\w*, capture:\s*\w*\s*-\s*code, start:\s*(\w*,\s*\w*),\s*end:\s(\w*,\s*\w*),\s*text:\s/---\n/" | awk '{ if (NR!=1) { print substr($$0, 3, length($$0)-5) } }' RS="---" > $(FENNEL_FILE)

compile: extract
	fennel --compile $(FENNEL_FILE) > $(LUA_FILE)

install: compile
	cp $(LUA_FILE) $(INSTALL_FILE)

init:
	echo "require('config')" > $(INIT_FILE)

clean:
	rm -rf build

.PHONY: build_dir query clean

