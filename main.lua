function love.load()
    Object = require "classic"

    require "entity"
    require "player"

    player = Player(3, 10)

    image = love.graphics.newImage("sprites.png")
    
    local image_width = image:getWidth()
    local image_height = image:getHeight()

    width = 24
    height = 24

    tilemap = {
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 8, 5, 4, 4, 4},
        {4, 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 6, 5, 4, 4, 4},
        {4, 5, 6, 6, 6, 6, 6, 5, 4, 5, 6, 6, 6, 6, 6, 5, 4, 4, 4},
        {4, 5, 5, 5, 5, 5, 6, 5, 5, 5, 6, 5, 5, 5, 5, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 5, 6, 6, 6, 6, 6, 5, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    }

    quads = {}

    for i = 0, 1 do
        for j = 0, 10 do
            table.insert(quads, love.graphics.newQuad(1 + j * (width + 2), 1 + i * (height + 2), width, height, image_width, image_height))
        end
    end
end

function love.update(dt)
end

function love.draw()
    for i, row in ipairs(tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(image, quads[tile], j * width, i * height)
            end
        end
    end

    love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)
end

function love.keypressed(key)

    local x = player.tile_x
    local y = player.tile_y

    if key == "left" then
        x = x - 1
    elseif key == "right" then
        x = x + 1
    elseif key == "up" then
        y = y - 1
    elseif key == "down" then
        y = y + 1
    end

    if isEmpty(x, y) then
        player.tile_x = x
        player.tile_y = y
    end
end

function isEmpty(x, y)
    return
    -- Money 
    tilemap[y][x] == 3 or
    -- Snow 
    tilemap[y][x] == 6 or 
    -- Warp
    tilemap[y][x] == 8 or
    -- Carpet
    tilemap[y][x] == 9
end
