local lg = love.graphics

local tilemap = Class {}

local function make_property_map(tiles, property)

    property_map = {}

    for i, e in ipairs(tiles) do
        if e.properties and e.properties[property] then
            self.property_map[e.id + 1] = true
        end
    end

    return property_map

end

function tilemap:init(data, resources)

    -- only tileset we care about
    local tileset = data.tilesets[1]

    -- texture load
    self.texture = lg.newImage("resources/tiles.png")

    -- collidable tiles map
    self.collidable_tiles = make_property_map(tileset.tiles, 'collidable')

    -- movable tiles map
    self.movable_tiles = make_property_map(tileset.tiles, 'movable')

    -- get image width/height for texture
    self.texture_width = tileset.imagewidth
    self.texture_height = tileset.imageheight

    -- height/width of individual tiles
    self.tile_width = tileset.tilewidth
    self.tile_height = tileset.tileheight

    -- pixel spacings between inviduual tiles to prevent glitches
    self.spacing = tileset.spacing

    -- handle only first layer
    local layer = data.layers[1]

    -- width/height in tiles of the actual map
    self.width = layer.width
    self.height = layer.height

    -- tile data, flat table of ids
    self.tiles = layer.data

    -- tile resources
    self.resources = resources

    -- tile quads
    self.quads = self:loadTileData(tileset.tilecount)

end

function tilemap:collidesWith(pos)

    local tile_index = self:worldCoordToTile(pos.x, pos.y)
    return self.collidable_tiles[tile_index]

end

function tilemap:worldCoordToTile(x, y)

    local tile_map = self
    local i = (math.floor(y / tile_map.tile_height) - 1) * tile_map.width + math.floor(x / tile_map.tile_width)
    return self.tiles[i]

end

function tilemap:loadTileData(resourceCount)

    local quads = {}
    local x, y = 0, 0

    for i=1, resourceCount do

        quads[#quads+1] = lg.newQuad(x, y, self.tile_width, self.tile_height, self.texture_width, self.texture_height)
        x = x + self.tile_width + self.spacing

    end

    return quads

end

function tilemap:update(dt)

end

function tilemap:draw()

    local tile_map = self
    local tile_resources = self.resources

    for i=1, #self.tiles do

        -- this is not even
        local x = (i % tile_map.width) * tile_map.tile_width
        local y = math.ceil(i / tile_map.height) * tile_map.tile_height

        local tile = self.tiles[i]
        if self.quads[tile] then
            lg.draw(self.texture, self.quads[tile], x, y, 0, 1, 1)
        end

    end

end

return tilemap
