require("nvim-treesitter.install").prefer_git = true
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    }
}
require'treesitter-context'.setup{}


