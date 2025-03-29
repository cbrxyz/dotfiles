return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "j-hui/fidget.nvim",
        },
        config = function()
            local nvim_lsp = require('lspconfig')

            local configs = require 'lspconfig/configs'
            local util = require 'lspconfig/util'

            -- Enable LSP Status!
            local lsp_status = require('lsp-status')
            lsp_status.register_progress()

            lsp_status.config({
                indicator_errors = '',
                indicator_warnings = '',
                indicator_info = '',
                indicator_hint = '',
                indicator_ok = 'Ok',
            })

            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(client, bufnr)
                local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                -- Enable completion triggered by <c-x><c-o>
                buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                local opts = { noremap = true, silent = true }

                -- See `:help vim.lsp.*` for documentation on any of the below functions
                buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
                buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
                buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
                buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
                buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
                buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
                buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
                    opts)
                buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
                buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
                buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
                buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
                buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
                buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
                buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
                buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
                buf_set_keymap('n', '<space>ff', '<cmd>lua vim.lsp.buf.format( { async = true } )<CR>', opts)

                -- Add support for LSP Status
                lsp_status.on_attach(client)
            end

            -- Add completion menu formatting
            local cmp_kinds = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "塞",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = ""
            }

            -- Setup ccls
            -- configs.ccls = {
            --     default_config = {
            --         cmd = { "ccls" },
            --         filetypes = { "c", "cpp", "objc", "objcpp" },
            --         root_dir = function(fname)
            --             return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname) or
            --                 util.path.dirname(fname)
            --         end,
            --     },
            -- }

            -- nvim_lsp.ccls.setup {
            --     init_options = {
            --         compilationDatabaseDirectory = "build",
            --         index = {
            --             threads = 0,
            --         },
            --         clang = {
            --             excludeArgs = { "-frounding-math" },
            --         }
            --     }
            -- }

            nvim_lsp.csharp_ls.setup {}

            -- YAML lanaguage server
            nvim_lsp.yamlls.setup {
                settings = {
                    yaml = {
                        schemaStore = {
                            url = "https://www.schemastore.org/api/json/catalog.json",
                            enable = true
                        }
                    }
                }
            }

            -- Lua language server
            nvim_lsp.lua_ls.setup {
                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            globals = { "vim", "hs" }
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                                ['/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'] = true,
                            },
                        },
                        telemetry = { enable = false }
                    }
                }
            }

            nvim_lsp.pyright.setup {
                single_file_support = false,
                root_dir = function(fname)
                    return util.root_pattern("requirements.txt", "setup.py", ".git")(fname) or util.path.dirname(fname)
                end,
            }

            require 'lspconfig'.ltex.setup {}
            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            local servers = { 'pyright', 'ts_ls', 'yamlls', 'lua_ls', 'jsonls', 'ltex' }
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            for _, lsp in ipairs(servers) do
                nvim_lsp[lsp].setup {
                    on_attach = on_attach,
                    flags = {
                        debounce_text_changes = 300,
                    },
                    capabilities = capabilities
                }
            end

            -- Setup nvim-cmp.
            local cmp = require 'cmp'

            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone,noselect',
                },
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'omni' },
                }, {
                    { name = 'buffer' },
                }),
                -- formatting = {
                --   format = function(entry, vim_item)
                --     vim_item.kind = ((cmp_kinds[vim_item.kind] .. " ") or '') .. vim_item.kind
                --       vim_item.menu = ({
                --         omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                --         buffer = "[Buffer]",
                --       })[entry.source.name]
                --     return vim_item
                --   end,
                -- },
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })

            vim.o.completeopt = "menu,menuone,noselect"
        end,
    },
    {
        "nvim-lua/lsp-status.nvim",
    },
    {
        "m-pilia/vim-ccls",
    },
    {
        "folke/lsp-colors.nvim",
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim"
        },
        config = function()
            none_ls = require('null-ls')
            none_ls.setup({
                sources = {
                    none_ls.builtins.diagnostics.codespell.with({
                        extra_args = { "-L", "selectin" }
                    }),
                    none_ls.builtins.diagnostics.cpplint,
                    none_ls.builtins.diagnostics.eslint,
                    none_ls.builtins.diagnostics.yamllint,
                    none_ls.builtins.diagnostics.shellcheck,
                    require("none-ls.diagnostics.ruff").with({
                        extra_args = { "--config", vim.fn.expand("~/.config/ruff.toml") }
                    }),
                    none_ls.builtins.formatting.black,
                    none_ls.builtins.formatting.latexindent,
                    none_ls.builtins.formatting.prettier,
                    none_ls.builtins.formatting.clang_format,
                    none_ls.builtins.formatting.shfmt,
                    require("none-ls.formatting.ruff").with({
                        extra_args = { "--config", vim.fn.expand("~/.config/ruff.toml") }
                    }),
                    -- none_ls.builtins.diagnostics.pylint,
                },
                on_attach = function(client, bufnr)
                    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "")
                end
            })
            vim.keymap.set('n', '<space>p', '<cmd>lua none_ls.toggle({})<CR>')
        end
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
