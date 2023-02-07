local util = require("util")

require("harpoon").setup({

-- projects = {
--     -- Yes $HOME works
--     ["$HOME/personal/vim-with-me/server"] = {
--         term = {
--             cmds = {
--                 "./env && npx ts-node src/index.ts"
--             }
--         }
--     }
-- },

})

util.keymap("n", "<leader>hf", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "[h]arpoon Toggle [f]ind Menu")
util.keymap("n", "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>", "[h]arpoon [a]dd File")

util.keymap("n", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "[h]arpoon File 1")
util.keymap("n", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "[h]arpoon File 2")
util.keymap("n", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "[h]arpoon File 3")
util.keymap("n", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "[h]arpoon File 4")

util.keymap('n', '[h', '<cmd>lua require("harpoon.ui").nav_file(-1)<CR>', '[h]arpoon Previous File')
util.keymap('n', ']h', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>', '[h]arpoon Next File')
