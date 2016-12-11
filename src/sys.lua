-- shortforms
local lg = love.graphics

local tiny = require "tiny"

-- resource loading and jank
-- TODO

-- entity systems go here and shit

local physicsSystem = tiny.processingSystem()

function physicsSystem:process(e, dt)

end

physicsSystem.filter = tiny.requireAll("p_x", "p_y", "v_x", "v_y", "mass")

local characterDrawingSystem = tiny.processingSystem()
characterDrawingSystem.filter = tiny.requireAll("p_x", "p_y", "d_w", "d_h", "d_colour")

function characterDrawingSystem:process(e, dt)

    local c = e.d_colour
    lg.setColor(c.r, c.g, c.b, c.a)
    lg.rectangle("fill", e.p_x - e.d_w/2, e.p_y - e.d_h/2)

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
            mass = 10 -- 10 what?

            -- colour for drawing, sorta cornflower blue (0x428bca)
            d_w = 16, d_h = 16,
            d_colour = {r = 66,  g = 139, b = 202, a = 255}

        }

    end

}
