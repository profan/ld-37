-- shortforms
local lg = love.graphics
local lw = love.window

local pause = {}

function pause:new()

    local new_obj = {}

    setmetatable(new_obj, self)
    self.__index = self

    return new_obj

end

-- dont give this args
function pause:init()

    self.delta = 0

end

function pause:update(dt)

    self.delta = self.delta + dt

end

function pause:keypressed(key, scancode, isrepeat)

    if key == "p" then
        Gamestate.pop()
    end

end

function pause:draw()

    local w, h = lg.getDimensions()
    local fsz = 12
    local hsz = fsz * 11

    lg.print("GAME IS PAUSED, PRESS P TO UNPAUSE!", w / 2 - hsz, h / 2 - fsz)

end

return pause
