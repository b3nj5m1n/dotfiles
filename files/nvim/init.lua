vim.cmd [[packadd packer.nvim]]
vim.cmd [[packadd aniseed]]

--[[ require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'Olical/aniseed'
end) ]]


require('aniseed.env').init()
