function love.load()
    Object = require "classic"

    require "entity"
    require "player"

    player = Player(15, 11)

    -- Loading font
    font = love.graphics.newFont("arcade.TTF", 14)

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

    -- Tilemap levels
    level = 1
    tilemap = {{
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4},
        {4, 5, 8, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 0, 5, 4, 4, 4},
        {4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4}},

        {
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 8, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 6, 5, 4, 4, 4},
        {4, 5, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 5, 5, 6, 5, 4, 4, 4},
        {4, 5, 0, 6, 6, 6, 6, 5, 4, 5, 6, 6, 6, 6, 6, 5, 4, 4, 4},
        {4, 5, 5, 5, 5, 5, 6, 5, 5, 5, 6, 5, 5, 5, 5, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 5, 6, 6, 6, 6, 6, 5, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},},

        {
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
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
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},},

        {
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 5, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 4, 4},
        {4, 5, 6, 6, 6, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 5, 4, 4},
        {4, 5, 6, 6, 6, 5, 5, 6, 6, 6, 6, 5, 5, 6, 6, 6, 5, 4, 4},
        {4, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 5, 4, 4},
        {4, 4, 5, 6, 5, 5, 5, 5, 6, 6, 5, 5, 5, 5, 6, 5, 4, 4, 4},
        {4, 4, 5, 6, 5, 4, 5, 6, 6, 6, 6, 5, 4, 5, 6, 5, 4, 4, 4},
        {4, 4, 5, 0, 5, 4, 5, 11, 6, 6, 6, 5, 4, 5, 8, 5, 4, 4, 4},
        {4, 4, 5, 5, 5, 4, 5, 5, 5, 5, 5, 5, 4, 5, 5, 5, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},
        {4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4},}
    }

    -- Player spawn on level
    player_pos = {
        {15, 11},
        {3, 11},
        {15, 8},
        {4, 8}}
    
    -- Player max steps p/ level
    maxSteps = {{12}, {19}, {25}, {43}}

    -- Player steps
    steps = 0

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

end

function love.draw()

    -- Setting the font
    love.graphics.setFont(font)

    -- Top interface with level, tiles and solved levels
    love.graphics.setColor(225/255, 240/255, 255/255)
    love.graphics.rectangle("fill", 0, 0, 456, 24)

    -- Bottom interface with reset button and points
    love.graphics.rectangle("fill", 0, 384, 456, 24)

    -- Level
    love.graphics.setColor(6/255, 84/255, 155/255)
    love.graphics.print("LEVEL " .. level, 36, 6)

    -- Tiles
    love.graphics.print(steps .. "/" .. maxSteps[level][1], 216, 6)

    -- Solved levels
    love.graphics.print("SOLVED " .. level - 1, 336, 6)

    -- Points
    love.graphics.print("POINTS ", 336, 390)

    -- Set color to default
    love.graphics.setColor(255, 255, 255)


    -- For each line on table
    for i, row in ipairs(tilemap[level]) do

        -- For each line item
        for j, tile in ipairs(row) do

            if tile == 11 then

                -- If hasMoney == true, 11 become a money tile
                if hasMoney == true then
                    tilemap[level][i][j] = 3

                -- If hasMoney == false, 11 become a snow tile
                else
                    tilemap[level][i][j] = 6
                end
            end

            -- Draw sprite if tile != 0
            if tile ~= 0 then
                love.graphics.draw(image, quads[tile], (j - 1) * width, (i - 0) * height)

            -- Draw water if tile == 0
            else
                love.graphics.draw(water_img, water[math.floor(currentFrame)], (j - 1) * width, (i - 0) * height)
            end

        end
    end

    -- Draw player
    love.graphics.draw(player.image, (player.tile_x - 1) * width, (player.tile_y - 0) * height)
    


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
        if tilemap[level][y][x] == 6 or tilemap[level][y][x] == 3 then
            tilemap[level][y][x] = 0
            steps = steps + 1

        -- If player moves to Carpet
        elseif tilemap[level][y][x] == 9 then
            tilemap[level][y][x] = 6
            steps = steps + 1
        end
        
        player.tile_x = x
        player.tile_y = y

        -- If player moves to Warp
        if tilemap[level][y][x] == 8 then

            steps = steps + 1

            -- Check if have money on the next level
            hasMoney = checkSteps()

            -- Player go to next level
            level = level + 1
            player.tile_x = player_pos[level][1]
            player.tile_y = player_pos[level][2]

            steps = 0

        end
    end
end

function isEmpty(x, y)
    return
    -- Money 
    tilemap[level][y][x] == 3 or
    -- Snow 
    tilemap[level][y][x] == 6 or 
    -- Warp
    tilemap[level][y][x] == 8 or
    -- Carpet
    tilemap[level][y][x] == 9
end

function checkSteps()
    if steps == maxSteps[level][1] then
        return true
    else
        return false
    end
end
