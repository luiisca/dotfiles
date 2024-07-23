local function setDynamicBgColor()
    local current_hour = tonumber(os.date("%H"))

    if current_hour >= 6 and current_hour < 18 then
        vim.cmd([[set background=light]])
    else
        vim.cmd([[set background=dark]])
    end
end

setDynamicBgColor()

local timer = vim.loop.new_timer()
timer:start(0, 1000 * 60, vim.schedule_wrap(function()
    setDynamicBgColor()
end))


return {
    -- gruvbox
    {
        'morhetz/gruvbox',
        -- priority = 1000,
        -- config = function()
        --     vim.cmd.colorscheme("gruvbox")
        -- end
    },

    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
    },

    -- catpuccin
    {
        "catppuccin/nvim",
    },

    -- everforest
    {
        "sainnhe/everforest",
    },

    -- monokai-pro
    {
        "loctvl842/monokai-pro.nvim",
        config = function()
            vim.cmd.colorscheme('monokai-pro')
        end
    }
}
