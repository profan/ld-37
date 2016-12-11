-- shortforms
local lg = love.graphics

local menu = {}

function menu:new(game_state)

    local new_obj = {}

    new_obj.game_state = game_state

    setmetatable(new_obj, self)
    self.__index = self

    return new_obj

end

function menu:init()

end

function menu:enter(from_state)

    print("entered menu, from state: ", from_state)

end

function menu:keypressed(key, scancode, isrepeat)

    if key == "space" then
        Gamestate.switch(self.game_state)
    end

end

function menu:update(dt)

end

function menu:draw()

    local w, h = lg.getDimensions()
    local hsz = 4 * 12

    lg.print("Hello, World!", w/2 - hsz, h/2 - 12)

end

return menu
