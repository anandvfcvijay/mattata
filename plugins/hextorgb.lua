--[[
    Copyright 2017 Matthew Hesketh <wrxck0@gmail.com>
    This code is licensed under the MIT. See LICENSE for details.
]]

local hextorgb = {}
local mattata = require('mattata')

function hextorgb:init()
    hextorgb.commands = mattata.commands(self.info.username)
    :command('hextorgb')
    :command('hrgb').table
    hextorgb.help = '/hextorgb <hex code> - Converts the given hex colour code into its RGB format. Alias: /hrgb.'
end

function hextorgb:on_message(message)
    local input = mattata.input(message.text)
    if not input
    then
        return mattata.send_reply(
            message,
            hextorgb.help
        )
    end
    input = input:gsub('#', '')
    local r = tonumber('0x' .. input:sub(1, 2))
    local g = tonumber('0x' .. input:sub(3, 4))
    local b = tonumber('0x' .. input:sub(5, 6))
    if not r
    or not g
    or not b
    then
        return mattata.send_reply(
            message,
            hextorgb.help
        )
    end
    return mattata.send_photo(
        message.chat.id,
        'https://placeholdit.imgix.net/~text?txtsize=1&bg=' .. input .. '&w=150&h=200',
        'rgb(' .. r .. ', ' .. g .. ', ' .. b .. ')'
    )
end

return hextorgb