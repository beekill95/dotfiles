return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
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
                name = "zettelkasten",
                path = "~/vaults/zettelkasten",
            },
        },
        notes_subdir = "notes",
        daily_notes = {
            folder = "diary",
            default_tags = { "diary" },
        },
        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- The timestamp is formatted as YYYYMMddHHMM for easier sort.
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            local prefix = tostring(os.date("%Y%m%d%H%M", os.time()))
            return prefix .. "-" .. suffix
        end,
        -- Edit the frontmatter to include the creation date.
        ---@param note obsidian.Note
        ---@return table
        note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
                note:add_alias(note.title)
            end

            local out = {
                id = note.id,
                aliases = note.aliases,
                tags = note.tags,
                -- Add the creation date to the frontmatter so Quartz outputs the right date.
                date = tostring(os.date("%Y-%m-%d", os.time())),
            }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,
        callbacks = {
            -- Add the updated field when the note is modified.
            ---@param client obsidian.Client
            ---@param note obsidian.Note
            pre_write_note = function(client, note)
                if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                    note.metadata.updated = tostring(os.date("%Y-%m-%d", os.time()))
                end

                return note
            end,
        },
        attachments = {
            img_folder = "assets"
        },
    },
}
