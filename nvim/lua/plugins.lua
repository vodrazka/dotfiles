local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
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
    print('packer not found, config not loaded')
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

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use 'wbthomason/packer.nvim' -- Have packer manage itself
    use { -- brew install ripgrep fd
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-treesitter/nvim-treesitter' } }
    }

    use 'vodrazka/paster.nvim'
    use 'neovim/nvim-lspconfig'
    --git
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'
    use 'ray-x/lsp_signature.nvim'
    use 'folke/neodev.nvim'
    use 'ThePrimeagen/harpoon'
    use 'eandrju/cellular-automaton.nvim'
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use 'folke/tokyonight.nvim'
    use 'rust-analyzer/rust-analyzer'
    -- use '~/code/github-desktop/paster.nvim'
    -- use 'github/copilot.vim'

    -- rust
    use 'simrat39/rust-tools.nvim'
    use 'mfussenegger/nvim-dap'
    use 'fatih/vim-go'
    use 'windwp/nvim-autopairs'
    use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
    use 'mrjones2014/smart-splits.nvim'
    use 'ggandor/leap.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
        print('Restart nvim to load plugins')
    else
        require('conf')
    end
end)
