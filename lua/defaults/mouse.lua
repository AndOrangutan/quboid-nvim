
-- :h default-mouse
-- :h popup-menu

--
-- vim.cmd.anoremenu{'PopUp.File\\ Tree <cmd>Neotree toggle<cr>'}
-- vim.cmd.anoremenu{'PopUp.\\ \\ Toggle\\ Diag.\\ List <cmd>Neotree toggle<cr>'}

--vim.cmd.anoremenu{'PopUp.Close\\ File <Cmd>:q!<CR>'}

-- Clear old PopUp Menu
vim.cmd.aunmenu{'PopUp'}

-- Add in Default actions with icons
vim.cmd.vnoremenu{'PopUp.\\ \\ Copy +y'}
vim.cmd.vnoremenu{'PopUp.\\ \\ Cut +x'}
vim.cmd.anoremenu{'PopUp.\\ \\ Paste +gP'}
vim.cmd.vnoremenu{'PopUp.\\ \\ Paste +P'}
vim.cmd.vnoremenu{'PopUp.\\ \\ Delete _x'}

vim.cmd.anoremenu{'PopUp.-Sep- <NOP>'}  -- Seperator

vim.cmd.anoremenu{'PopUp.\\ \\ File\\ Tree <cmd>Neotree toggle<cr>'}
vim.cmd.anoremenu{'PopUp.\\ \\ Code\\ Action <cmd>CodeActionMenu<cr>'}
