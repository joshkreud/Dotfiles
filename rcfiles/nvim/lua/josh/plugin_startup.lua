-- Wilder Commandmenu
local wilder = require("wilder")
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    border= 'rounded',
    pumblend = 20,
    highlighter = wilder.basic_highlighter(),
    left = { ' ', wilder.popupmenu_devicons() },
    right = { ' ', wilder.popupmenu_scrollbar() },
  })
  )
)
wilder.set_option('pipeline', {
  wilder.branch(
  wilder.cmdline_pipeline({
    fuzzy = 1,
    set_pcre2_pattern = 1,
  }),
  wilder.python_search_pipeline({
    pattern = 'fuzzy',
  })
  ),
})

-- Indent Blankline settings to show space dots and newlines
vim.opt.list = true
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context_start = true,
}
