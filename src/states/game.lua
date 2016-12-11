-- shortforms
local lg = love.graphics

-- lib requires
local tiny = require "tiny"

-- data requires
local map_data = require "level"

-- resource loading and jank
-- TODO

-- entity systems go here and shit

local updateSystemFilter = tiny.rejectAll("is_drawing_system")
local drawSystemFilter = tiny.requireAll("is_drawing_system")

local inputSystem = tiny.processingSystem()
inputSystem.filter = tiny.requireAll("intents")

inputSystem.keys = {

    w = "forward"

}

function inputSystem:process(e, dt)

    for key, intent in pairs(self.keys) do
        if love.keyboard.isDown(key) then
            e.intents[intent](e, dt)
        end
    end

end

local physicsSystem = tiny.processingSystem()
physicsSystem.filter = tiny.requireAll("p_x", "p_y", "v_x", "v_y", "mass")
function physicsSystem:process(e, dt)

end

local characterDrawingSystem = tiny.processingSystem({is_drawing_system = true})
characterDrawingSystem.filter = tiny.requireAll("p_x", "p_y", "d_w", "d_h", "d_colour")

function characterDrawingSystem:process(e, dt)

    local c = e.d_colour
    lg.setColor(c.r, c.g, c.b, c.a)
    lg.rectangle("fill", e.p_x - e.d_w/2, e.p_y - e.d_h/2, e.d_w, e.d_h)

    -- dis bad, but hey
    lg.setColor(255, 255, 255)

end

-- entity definitions go here

local units = {

    player = function(x, y)

        local new_player = {

            health = 100,
            p_x = x, p_y = y,
            v_x = 0, v_y = 0,
            mass = 10, -- 10 what?

            -- input shite?
            intents = {
                forward = function(self, dt)
                    print "pressed forward!"
                end
            },

            -- colour for drawing, sorta cornflower blue (0x428bca)
            d_w = 16, d_h = 16,
            d_colour = {r = 66,  g = 139, b = 202, a = 255}

        }

        return new_player

    end

}

-- game state here
local game = {}

function game:new(pause_state)

    local new_obj = {}

    new_obj.pause_state = pause_state

    setmetatable(new_obj, self)
    self.__index = self

    return new_obj

end

function game:init()

    -- tilemap shite
    self.map = TileMap(map_data, nil)

    -- worlds an fuck
    self.world = tiny.world(
        inputSystem,
        physicsSystem,
        characterDrawingSystem
    )

    local new_player = units.player(128, 128)

    self.world:add(new_player)

end

function game:keypressed(key, scancode, isrepeat)

    if key == "p" then
        Gamestate.push(self.pause_state)
    end

end

function game:update(dt)

    self.world:update(dt, updateSystemFilter)

end

function game:draw()

    local w, h = lg.getDimensions()
    local hsz = 4 * 12

    lg.print("Hello, Game!", w/2 - hsz, h/2 - 12)

    self.map:draw()
    self.world:update(dt, drawSystemFilter)

end

function game:enter(from_state)

end

return game
