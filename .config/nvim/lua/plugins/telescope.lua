return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-ui-select.nvim" },
        { 
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    config = function()
        require("telescope").setup {
            defaults = {
                color_devicons = false,
                layout_strategy = "vertical",
                sorting_strategy = "ascending",
                file_ignore_patterns = {
                    "^.git/",
                    "node_modules/*",
                    "public/*"
                },
                mappings = {
                    i = {
                        -- meta-p (== alt-p)
                        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
                    },
                    n = {
                        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
                    }
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = false,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                ["ui-select"] = {
                    require("telescope.themes").get_ivy {
                        layout_strategy = "bottom_pane"
                    }
                }
            },
        }

        local builtin = require 'telescope.builtin'

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)

        vim.keymap.set('n', '<leader>pn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end)

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
    end
}
