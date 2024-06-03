local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
    vim.notify("Obsidian plugin not found! Quit configuring!")
    return
end


obsidian.setup({
    workspaces = {
        {
            name = "zettelkasten",
            path = "~/vaults/zettelkasten",
        },
    },

    -- see below for full list of options 👇
    completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local prefix = os.date("%Y%m%d%H%M", os.time())

        if title ~= nil then
            -- If title is given, transform it into valid file name.
            local suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            return prefix .. "-" .. suffix
        else
            return prefix
        end
    end,
})
