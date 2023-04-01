local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        print('packer downloaded')
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end
    }
}
)

return packer.startup(function(use)
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
    use { -- brew install ripgrep fd
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-treesitter/nvim-treesitter' } }
    }
    --use {'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim'}
    use 'mattn/webapi-vim'

    use 'vodrazka/paster.nvim'
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'ray-x/lsp_signature.nvim'
    use 'ThePrimeagen/harpoon'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'windwp/nvim-autopairs'
    use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
    use 'mrjones2014/smart-splits.nvim'
    use 'ggandor/leap.nvim'
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }

    use 'folke/neodev.nvim'

    use 'github/copilot.vim'

    --use 'eandrju/cellular-automaton.nvim'
    --use {
    --    "SmiteshP/nvim-navic",
    --    requires = "neovim/nvim-lspconfig"
    --}
    --use 'rust-analyzer/rust-analyzer'
    -- use '~/code/github-desktop/paster.nvim'

    -- rust
    --use 'simrat39/rust-tools.nvim'
    --use 'mfussenegger/nvim-dap'
    --use 'fatih/vim-go'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
