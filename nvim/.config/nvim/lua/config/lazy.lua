-- bootstrap from github
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "git@github.com:folke/lazy.nvim.git",
      lazypath,
    })
  vim.opt.runtimepath:prepend(lazypath)


require("lazy").setup({})
