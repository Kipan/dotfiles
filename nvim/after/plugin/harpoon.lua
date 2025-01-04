local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
{ desc = "Open harpoon window" })




vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-N>", function() harpoon:list():next() end)

