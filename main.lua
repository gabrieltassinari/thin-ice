function love.load()
    Object = require "classic"

    require "entity"
    require "player"

    player = Player(15, 7)

    -- Loading sprites
    image = love.graphics.newImage("sprites.png")
    local image_width = image:getWidth()
    local image_height = image:getHeight()

    -- Water sprites
    water_img = love.graphics.newImage("water.png")
    local w_width = water_img:getWidth()
    local w_height = water_img:getHeight()

    width = 24
    height = 24


    level = 0
    tilemap = {
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 4, 4, 4},
        {4, 4, 5, 8, 5, 4, 4, 4, 4, 4, 4, 4, 4, 5, 0, 5, 4, 4, 4},
        {4, 4, 5, 6, 5, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 5, 4, 4, 4},
        {4, 4, 5, 6, 5, 5, 5, 5, 5, 5, 6, 6, 5, 5, 6, 5, 4, 4, 4},
        {4, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 4, 4, 4},
        {4, 4, 5, 6, 6, 5, 5, 6, 6, 5, 5, 5, 5, 6, 6, 5, 4, 4, 4},
        {4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 5, 5, 5, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
    }

    -- Render the sprites
    quads = {}

    for i = 0, 1 do
        for j = 0, 9 do
            table.insert(quads, love.graphics.newQuad(1 + j * (width + 2), 1 + i * (height + 2), width, height, image_width, image_height))
        end
    end

    -- Render water frames
    water = {}

    for i = 0, 3 do

        for j = 0, 9 do
            table.insert(water, love.graphics.newQuad(1 + j * (width + 2), 1 + i * (height + 2), width, height, w_width, w_height))
        end
    end

    currentFrame = 1

end

function love.update(dt)

    -- Water animation
    currentFrame = currentFrame + 10 * dt
    if currentFrame >= 40 then
        currentFrame = 1
    end

    -- Chamar a função para trocar de fase
end

function love.draw()

    -- For each line on table
    for i, row in ipairs(tilemap) do

        -- For each line item
        for j, tile in ipairs(row) do

            -- Draw sprite if tile != 0
            if tile ~= 0 then
                love.graphics.draw(image, quads[tile], j * width, i * height)

            -- Draw water if tile == 0
            else
                love.graphics.draw(water_img, water[math.floor(currentFrame)], j * width, i * height)
            end
        end
    end

    -- Draw player
    love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)
end

function love.keypressed(key)

    local x = player.tile_x
    local y = player.tile_y

    -- Player moves
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

        -- If player moves to snow or to money
        if tilemap[y][x] == 6 or tilemap[y][x] == 3 then
            tilemap[y][x] = 0
            
        -- If player moves to Carpet
        elseif tilemap[y][x] == 9 then
            tilemap[y][x] = 6

        -- If player moves to Warp
        elseif tilemap[y][x] == 8 then
            level = level + 1
        end

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
