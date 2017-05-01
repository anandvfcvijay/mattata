--[[
    Copyright 2017 Matthew Hesketh <wrxck0@gmail.com>
    This code is licensed under the MIT. See LICENSE for details.
]]

local loremipsum = {}
local mattata = require('mattata')
local http = require('socket.http')

function loremipsum:init()
    loremipsum.commands = mattata.commands(self.info.username):command('loremipsum').table
    loremipsum.help = '/loremipsum - Generates a paragraph of Lorem Ipsum text.'
end

function loremipsum:on_message(message, configuration, language)
    local str, res = http.request('http://loripsum.net/api/1/medium/plaintext')
    if res ~= 200
    then
        return mattata.send_reply(
            message,
            language['errors']['connection']
        )
    end
    return mattata.send_message(
        message.chat.id,
        str
    )
end

return loremipsum