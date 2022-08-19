vim.g.tex_flavor = "latex"
vim.g.vimtex_compiler_method = "latexmk"

-- PDF viewer
vim.g.vimtex_view_method = "general"
vim.g.vimtex_view_general_viewer = "zathura"
vim.g.vimtex_view_forward_search_on_start = 1

-- don't open quickfix window if there are only warnings
vim.g.vimtex_quickfix_open_on_warning = 0

-- ignore certain warnings
vim.cmd("let g:vimtex_quickfix_ignore_filters = ['Overfull', 'Underfull', 'has already been used']")

-- configure table of contents
-- vim.cmd("let g:vimtex_toc_config={'split_pos': 'full', 'layer_status': {'content': 1, 'label': 0, 'todo': 0, 'include': 0}, 'show_help': 1")

-- omni completion for BibTeX
vim.cmd("let g:vimtex_complete_bib = {'simple': 1, 'recursive': 1}")

-- syntax highlighting via Tree-sitter
vim.g.vimtex_syntax_enabled = 0
