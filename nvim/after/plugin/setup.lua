local status, lfs = pcall(require, "telescope")
if (not status) then
    return
end
local prefix = vim.fn.expand("~/.config")
local my_search_dirs = { '.', prefix .. '/nvim', '~/code/github-desktop/paster.nvim' }

require('smart-splits').setup({})
local actions = require "telescope.actions"
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-S-j>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            n = {
            },
        }

    },
    pickers = {
        find_files = {
            search_dirs = my_search_dirs
        },
        live_grep = {
            search_dirs = my_search_dirs
        }
    }
}
vim.cmd [[ colorscheme koehler ]]
vim.cmd [[hi Normal guibg=NONE ctermbg=NONE]]
