return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "vault",
                path = "/Users/cameronbrown/Library/Mobile Documents/iCloud~md~obsidian/Documents/vault",
            },
        },
        daily_notes = {
            folder = "dailies",
            date_format = "%Y-%m-%d",
        },
        log_level = vim.log.levels.ERROR,
        ui = {
            enable = true,
            update_debounce = 200,  -- update delay after a text change (in milliseconds)
            max_file_length = 5000, -- disable UI features for files with more than this many lines
            -- Define how various check-boxes are displayed
            checkboxes = {
                -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                ["x"] = { char = "", hl_group = "ObsidianDone" },
                -- Replace the above with this if you don't have a patched font:
                -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                -- You can also add more custom ones...
            },
            -- Use bullet marks for non-checkbox lists.
            bullets = { char = "•", hl_group = "ObsidianBullet" },
            external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            -- Replace the above with this if you don't have a patched font:
            -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            reference_text = { hl_group = "ObsidianRefText" },
            highlight_text = { hl_group = "ObsidianHighlightText" },
            tags = { hl_group = "ObsidianTag" },
            block_ids = { hl_group = "ObsidianBlockID" },
            hl_groups = {
                -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                ObsidianTodo = { bold = true, fg = "#f78c6c" },
                ObsidianDone = { bold = true, fg = "#89ddff" },
                ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
                ObsidianTilde = { bold = true, fg = "#ff5370" },
                ObsidianImportant = { bold = true, fg = "#d73128" },
                ObsidianBullet = { bold = true, fg = "#89ddff" },
                ObsidianRefText = { underline = true, fg = "#c792ea" },
                ObsidianExtLinkIcon = { fg = "#c792ea" },
                ObsidianTag = { italic = true, fg = "#89ddff" },
                ObsidianBlockID = { italic = true, fg = "#89ddff" },
                ObsidianHighlightText = { bg = "#75662e" },
            },
        },
        mappings = {
            ["<cr>"] = {
                action = function()
                    -- follow link if possible
                    local obsidian = require("obsidian")
                    if obsidian.util.cursor_on_markdown_link(nil, nil, true) then
                        require("obsidian.commands.follow_link")(obsidian.get_client(), {})
                    end

                    -- toggle task if possible
                    -- cycles through your custom UI checkboxes, default: [ ] [~] [>] [x]
                    -- Allow line_num to be optional, defaulting to the current line if not provided
                    line_num = unpack(vim.api.nvim_win_get_cursor(0))
                    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]

                    local checkbox_pattern = "^%s*- %[.] "
                    local checkboxes = { " ", "x" }

                    if not string.match(line, checkbox_pattern) then 
                        return
                        -- local unordered_list_pattern = "^(%s*)[-*+] (.*)"
                        -- if string.match(line, unordered_list_pattern) then
                        --     line = line -- string.gsub(line, unordered_list_pattern, "%1- [ ] %2")
                        -- else
                        --     line = line -- string.gsub(line, "^(%s*)", "%1- [ ] ")
                        -- end
                    else
                        for i, check_char in require("obsidian.itertools").enumerate(checkboxes) do
                            if string.match(line, "^%s*- %[" .. obsidian.util.escape_magic_characters(check_char) .. "%].*") then
                                if i == #checkboxes then
                                    i = 0
                                end
                                line = require("obsidian").util.string_replace(line, "- [" .. check_char .. "]",
                                    "- [" .. checkboxes[i + 1] .. "]", 1)
                                break
                            end
                        end
                    end
                    -- 0-indexed
                    vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, { line })
                end,
                opts = { buffer = true },
            }
        }
        -- see below for full list of options 👇
    },
    config = function(_, opts)
        require("obsidian").setup(opts)

        -- keymaps
        -- Normal mode key mappings
        vim.api.nvim_set_keymap('n', 'ot', ':ObsidianToday<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'om', ':ObsidianTomorrow<CR>', { noremap = true, silent = true })

        -- Function to execute :ObsidianToday with a given number
        local function obsidian_today_with_number(number)
            vim.cmd('ObsidianToday ' .. number)
        end

        -- Map 'od' followed by a number dynamically
        for i = -9, 9 do
            vim.api.nvim_set_keymap(
                'n',
                'od' .. i,
                '',
                {
                    noremap = true,
                    callback = (function(num)
                        return function() obsidian_today_with_number(num) end
                    end)(i),
                    silent = true,
                }
            )
        end
    end,
}
