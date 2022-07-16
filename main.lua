function love.load()

    Object = require "classic"
    require "sprites"
    require "tilemap"
    require "entity"
    require "player"

    player = Player(15, 11)

    -- Loading font
    font = love.graphics.newFont("fonts/arcade.TTF", 14)

    -- Loading sprites
    image = love.graphics.newImage("sprites/sprites.png")

    -- Water sprites
    water_img = love.graphics.newImage("sprites/water.png")

    -- Key sprites
    key_img = love.graphics.newImage("sprites/key.png")
    
    -- Current level
    level = 1

    -- Tilemap levels
    tilemap = getTilemap()
    
    -- Player max steps p/ level
    maxSteps = {12, 19, 25, 43, 41, 41, 66, 82, 93, 208, 
                132, 138, 128, 131, 227, 181, 161, 179, 172}

    -- Player steps
    steps = 0

    -- Player points
    points = 0

    -- Render tiles sprites
    quads = renderSprites("tiles", image, 24, 24)

    -- Render water sprites
    water = renderSprites("water", water_img, 24, 24)

    -- Render key sprites
    key = renderSprites("key", key_img, 24, 24)

    -- Animation frames
    waterFrame = 1
    keyframe = 1

    haveKey = false
end

function love.update(dt)

    -- Water animation
    waterFrame = waterFrame + 10 * dt
    if waterFrame >= 40 then
        waterFrame = 1
    end

    -- Key animation
    keyframe = keyframe + 10 * dt
    if keyframe >= 16 then
        keyframe = 1
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
    love.graphics.print(steps .. "/" .. maxSteps[level], 216, 6)

    -- Solved levels
    love.graphics.print("SOLVED " .. level - 1, 336, 6)

    -- Points
    love.graphics.print("POINTS " .. points, 312, 390)

    -- Set color to default
    love.graphics.setColor(255, 255, 255)


    -- Tiles width and height
    local width = 24
    local height = 24

    -- For each line on table
    for i, row in ipairs(tilemap[level]) do

        -- For each line item
        for j, tile in ipairs(row) do

            if tile == 12 then

                -- If hasMoney == true, 12 become a money tile
                if hasMoney == true then
                    tilemap[level][i][j] = 3

                -- If hasMoney == false, 12 become a snow tile
                else
                    tilemap[level][i][j] = 6
                end
            end
            
            -- Draw key
            if tile == 13 then
                love.graphics.draw(key_img, key[math.floor(keyframe)], (j - 1) * width, (i - 0) * height)

            -- Draw tiles
            elseif tile ~= 0 then
                love.graphics.draw(image, quads[tile], (j - 1) * width, (i - 0) * height)

            -- Draw water
            else
                love.graphics.draw(water_img, water[math.floor(waterFrame)], (j - 1) * width, (i - 0) * height)
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

        points = points + 1
        steps = steps + 1

        -- If player moves to snow
        if tilemap[level][y][x] == 6 then
            tilemap[level][y][x] = 0

        -- If player moves to money
        elseif tilemap[level][y][x] == 3 then
            tilemap[level][y][x] = 0
            points = points + 100
        
        -- If player moves to carpet
        elseif tilemap[level][y][x] == 9 then
            tilemap[level][y][x] = 6

        -- If player moves to lock
        elseif tilemap[level][y][x] == 11 then
            tilemap[level][y][x] = 0

        -- If player moves to key
        elseif tilemap[level][y][x] == 13 then
            tilemap[level][y][x] = 0
        end
        
        -- Update player position
        player.tile_x = x
        player.tile_y = y

        -- If player moves to Warp
        if tilemap[level][y][x] == 8 then
            
            -- Points per level
            points = points + (level * 14) + 10

            -- Check if have money on the next level
            hasMoney = checkSteps()

            -- Player go to next level
            level = level + 1
            
            -- Reset steps counter
            steps = 0

        end
    end
end

function isEmpty(x, y)

    -- If tile is money, snow, warp or carpet
    if tilemap[level][y][x] == 3 or tilemap[level][y][x] == 6 or
       tilemap[level][y][x] == 8 or tilemap[level][y][x] == 9 then
        return true
    
    -- If tile is lock
    elseif tilemap[level][y][x] == 11 and haveKey == true then
        return true
    
    -- If tile is key
    elseif tilemap[level][y][x] == 13 then
        haveKey = true
        return true
    end

end

function checkSteps()
    if steps == maxSteps[level] then
        return true
    else
        return false
    end
end
