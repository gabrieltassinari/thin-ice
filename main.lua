function love.load()

    Object = require "src/classic"
    require "src/sprites"
    require "src/tilemap"
    require "src/player"

    player = Player(15, 11)

    -- Loading font
    font = love.graphics.newFont("src/fonts/arcade.TTF", 14)

    -- Background music
    song = love.audio.newSource("src/music/song.ogg", "stream")
    song:setLooping(true)
    song:play()

    -- Render tiles sprites
    image = love.graphics.newImage("src/images/sprites.png")
    quads = renderSprites("tiles", image)

    -- Render player sprites
    puffle_img = love.graphics.newImage("src/images/player.png")
    puffle = renderSprites("player", puffle_img)

    -- Render water sprites
    water_img = love.graphics.newImage("src/images/water.png")
    water = renderSprites("water", water_img)

    -- Render key sprites
    key_img = love.graphics.newImage("src/images/key.png")
    key = renderSprites("key", key_img)
    
    -- Animation frames
    playerFrame = 1
    waterFrame = 1
    keyFrame = 1

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

end

function love.update(dt)

    -- Player animation
    playerFrame = playerFrame + 10 * dt
    if playerFrame >= 32 then
        playerFrame = 6
    end

    -- Water animation
    waterFrame = waterFrame + 10 * dt
    if waterFrame >= 40 then
        waterFrame = 1
    end

    -- Key animation
    keyFrame = keyFrame + 10 * dt
    if keyFrame >= 16 then
        keyFrame = 1
    end

end

function love.draw()

    if level <= 12 then

        -- Setting the font
        love.graphics.setFont(font)

        -- Top interface with level, tiles and solved levels
        love.graphics.setColor(225/255, 240/255, 255/255)
        love.graphics.rectangle("fill", 0, 0, 456, 24)

        -- Bottom interface with reset button and points
        love.graphics.rectangle("fill", 0, 384, 456, 24)

        -- Level
        love.graphics.setColor(6/255, 84/255, 155/255)
        love.graphics.print("LEVEL " .. level, 30, 6)

        -- Tiles
        love.graphics.print(steps .. "/" .. maxSteps[level], 192, 6)

        -- Solved levels
        love.graphics.print("SOLVED " .. level - 1, 312, 6)

        -- Points
        love.graphics.print("POINTS " .. points, 300, 390)

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
                    love.graphics.draw(key_img, key[math.floor(keyFrame)], (j - 1) * width, (i - 0) * height)

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
        player:draw()

    -- Final screen
    else
        love.graphics.draw(love.graphics.newImage("src/images/final.png"))
    end
end

function love.keypressed(key)
    if level <= 12 then
        player:keyPressed(key)
    end
end
