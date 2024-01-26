function setDynamicBgColor()
    local current_hour = tonumber(os.date("%H"))

    if current_hour >= 6 and current_hour < 18 then
        vim.cmd([[set background=light]])
    else
        vim.cmd([[set background=dark]])
    end
end

setDynamicBgColor()

local timer = vim.uv.new_timer()
timer:start(0, 1000 * 60, vim.schedule_wrap(function()
    setDynamicBgColor()
end))


return {
    -- gruvbox
    {
        'morhetz/gruvbox', 
        config = function() 
            vim.cmd.colorscheme("gruvbox")
        end 
    },

    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
    },
}
