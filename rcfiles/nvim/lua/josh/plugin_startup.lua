local wilder = require("wilder")
wilder.set_option('renderer', wilder.popupmenu_renderer({
  pumblend = 20,
  highlighter = wilder.basic_highlighter(),
  left = { ' ', wilder.popupmenu_devicons() },
  right = { ' ', wilder.popupmenu_scrollbar() },
}))
