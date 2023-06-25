local status_ok, neorg = pcall(require, "neorg")
if not status_ok then
    vim.notify("Neorg plugin not found! Quit configuring!")
    return
end

neorg.setup {
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        -- Manages Neorg workspaces
        ["core.dirman"] = {
            config = {
                workspaces = {
                    zettelkasten = "~/zettelkasten",
                },
                default_workspace = "zettelkasten",
            },
        },
    },
}
