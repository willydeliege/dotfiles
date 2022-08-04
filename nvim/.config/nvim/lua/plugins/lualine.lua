local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end
lualine.setup {
    options = {
        icons_enabled = true,
        theme = 'everforest',
        component_separators = { '', '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { '' },
        lualine_y = { 'encoding', 'filetype' },
        lualine_z = { { 'location', color = { fg = 'grey', bg = 'gray21' } } }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
