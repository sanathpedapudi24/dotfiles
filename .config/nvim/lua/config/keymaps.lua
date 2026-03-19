local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- this are for buffer cycling
local map = vim.keymap.set
if vim.fn.exists(":BufferLineCycleNext") == 2 then
  map("n", "<leader>n", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
  map("n", "<leader>p", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
else
  map("n", "<leader>n", "<cmd>bnext<cr>", { desc = "Next Buffer" })
  map("n", "<leader>p", "<cmd>bprev<cr>", { desc = "Prev Buffer" })
end
