Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "sprites/player.png")
    self.tile_x = x
    self.tile_y = y
    self.haveKey = false
end

function Player:draw()
    love.graphics.draw(player.image, (player.tile_x - 1) * 24, player.tile_y * 24)
end

function Player:keyPressed(key)

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

    -- If next position is valid
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
            
            -- Save current position
            position_x = x
            position_y = y

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
    elseif tilemap[level][y][x] == 11 and player.haveKey == true then
        return true
    
    -- If tile is key
    elseif tilemap[level][y][x] == 13 then
        player.haveKey = true
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