return {
  {
    "rcarriga/nvim-notify",
    opts = {
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "slide",
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T"
      },
      timeout = 2000,
      top_down = true
    }
  }
}
