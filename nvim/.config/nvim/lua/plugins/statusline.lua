return {
  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("config.heirline")
    end,
  },
}
