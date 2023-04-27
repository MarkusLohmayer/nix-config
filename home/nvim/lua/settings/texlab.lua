return {
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = { "-pdflatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
        onSave = true,
        forwardSearchAfter = true,
      },
      forwardSearch = {
        -- executable = "zathura",
        -- args = {
        --   "--synctex-forward",
        --   "%l:1:%f",
        --   "%p",
        -- },
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = {
          "-r", -- reload file
          "-g", -- leave Skim in the background
          "-b", -- show yellow reading bar
          "%l", -- line number
          "%p", -- pdf file
          "%f", -- tex file
        },
      },
      chktex = {
        onOpenAndSave = true,
      },
      -- diagnostics = {
      --   -- ignoredPatterns = {
      --   --   "Overfull",
      --   --   "Underfull",
      --   --   "has already been used",
      --   -- },
      -- },
    },
  },
}
