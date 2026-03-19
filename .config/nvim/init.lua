-- Bootstrap lazy.nvim, LazyVim and your plugins
-- NOTE: The below code is only for the use of clipboard in wsl windows no need for linux
-- You Can Just ignore the below code
-- vim.opt.clipboard = {
--   name = "win32yank",
--   copy = {
--     ["+"] = "win32yank.exe -i --crlf",
--     ["*"] = "win32yank.exe -i --crlf",
--   },
--   paste = {
--     ["+"] = "win32yank.exe -o --lf",
--     ["*"] = "win32yank.exe -o --lf",
--   },
--   cache_enabled = 0,
-- }
require("config.lazy")
require("config.keymaps")

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h10"
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_scroll_animation_length = 0.5
  vim.g.neovide_opacity = 0.4
  vim.g.neovide_background_color = "#0f1117"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_fullscreen = false
end
vim.opt.swapfile = true
vim.opt.shortmess:append("A")
vim.opt.directory = vim.fn.stdpath("data") .. "/swap//"
