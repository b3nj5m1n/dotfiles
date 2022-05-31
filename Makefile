all: neovim dotter

neovim: ./files/nvim/config.norg
	cd ./files/nvim/ && $(MAKE) all

dotter:
	dotter deploy -f

clean:
	cd ./files/nvim/ && $(MAKE) clean

.PHONY: build_dir query clean

