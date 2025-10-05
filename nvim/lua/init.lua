-- LSP Config
local lsp = require('lsp-zero')

vim.o.updatetime = 250
lsp.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  -- vim.keymap.set("n", "<C-q>", function() vim.lsp.buf.workspace_symbol() end, opts)
  lsp.default_keymaps({buffer = bufnr})

  -- Open diagnostic in a hover when cursor stays on the error
  vim.api.nvim_create_autocmd("CursorHold", {
  buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end

})
end)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        ['<Tab>'] = cmp.mapping.confirm({select = true}),
        ['<C-c>'] = cmp.mapping.abort(),
        ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
        ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
        ['<C-l>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item({behavior = 'insert'})
            else
                cmp.complete()
            end
        end),
        ['<C-j>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({behavior = 'insert'})
            else
                cmp.complete()
            end
        end),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
})

-- Disable visualization of diagnostic inline
vim.diagnostic.config({
    virtual_text = false
})


local util = require "lspconfig/util"
require'lspconfig'.gopls.setup {
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        fillstruct = true,
      },
    },
  },
}
require'lspconfig'.clangd.setup{}
require'lspconfig'.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
                ignored = {
                    leptos_macro = {
                        "server",
                    },
                },
            },
        }
    }
})
require'lspconfig'.zls.setup{}




-- Telescope config
local actions = require('telescope.actions')
require('telescope').setup{
	defaults = {
		path_display = { "smart" }, 
                fname_width = 25,
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-c>"] = actions.close,
				["<esc>"] = actions.close,
			},
			n = {
				["<C-c>"] = actions.close,
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
	-- Default configuration for builtin pickers goes here:
	-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
            find_files = {
                theme = "ivy",
            },
            live_grep = {
                theme = "ivy",
            },
            git_files = {
                theme = "ivy",
            },
            lsp_references = {
                theme = "ivy",
            },
	},
	extensions = {
	-- Your extension configuration goes here:
	-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	}
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
vim.keymap.set('n', '<C-e>', function() builtin.lsp_references({fname_width=70}) end, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


