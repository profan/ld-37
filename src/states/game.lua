-- shortforms
local lg = love.graphics

local game = Class {}

function game:init()

end

function game:update(dt)

end

function game:draw()

    local w, h = lg.getDimensions()
    local hsz = 4 * 12

    lg.print("Hello, Game!", w/2 - hsz, h/2 - 12)

end

function game:enter(from_state)

    print("entered game, from state: ", from_state)

end

return game
