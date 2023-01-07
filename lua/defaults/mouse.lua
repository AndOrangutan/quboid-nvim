
-- :h default-mouse
-- :h popup-menu

--
-- vim.cmd.anoremenu{'PopUp.File\\ Tree <cmd>Neotree toggle<cr>'}
-- vim.cmd.anoremenu{'PopUp.\\ \\ Toggle\\ Diag.\\ List <cmd>Neotree toggle<cr>'}

--vim.cmd.anoremenu{'PopUp.Close\\ File <Cmd>:q!<CR>'}

-- Clear old PopUp Menu
vim.cmd.aunmenu{'PopUp'}

vim.cmd.anoremenu{'PopUp.\\ \\ Undo\\ (u) u'}
vim.cmd.anoremenu{'PopUp.\\ \\ Redo\\ (<C-r>) <C-r>'}

-- Add in Default actions with icons
vim.cmd.vnoremenu{'PopUp.\\ \\ Copy\\ (v+y) +y'}
vim.cmd.vnoremenu{'PopUp.\\ \\ Cut\\ (v+x) +x'}
vim.cmd.anoremenu{'PopUp.\\ \\ Paste\\ (+gP) +gP'}
vim.cmd.vnoremenu{'PopUp.\\ \\ Paste\\ (p) +P'}
vim.cmd.vnoremenu{'PopUp.\\ \\ Delete\\ (x) _x'}

vim.cmd.anoremenu{'PopUp.-Sep- <NOP>'}  -- Seperator

vim.cmd.anoremenu{'TestPop.\\ \\ Delete\\ (x) _x'}

vim.cmd.anoremenu{'PopUp.-Sep- <NOP>'}  -- Seperator

vim.cmd.anoremenu{'PopUp.\\ \\ File\\ Tree\\ (<L>nn) <cmd>Neotree toggle<cr>'}

vim.cmd.anoremenu{'PopUp.\\ \\ Code\\ Action<Tab>(<L>ca) <cmd>CodeActionMenu<cr>'}
vim.cmd.anoremenu{'PopUp.\\ \\ Code\\ Action(<L>ca) <cmd>CodeActionMenu<cr>'}
-- anoremenu PopUp.115\\ Code\    Action(<L>ca) <cmd>CodeActionMenu<cr>
-- vim.cmd.anoremenu{'PopUp.\\ LSP <cmd>popup! TestPop<cr>'}
-- vim.cmd.anoremenu{'TestPop.\\ \\ Delete\\ (x) _x'}
-- vim.cmd.anoremenu{'TestPop.\\ \\ Delete\\ (x) _x'}
-- vim.cmd.anoremenu{'TestPop.\\ \\ Delete\\ (x) _x'}


