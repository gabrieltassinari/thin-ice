function renderSprites(sprite, image, width, height)

    local image = image

    local image_width = image:getWidth()
    local image_height = image:getHeight()
    
    local width = width
    local height = height
    
    if sprite == "water" then

        water = {}
        
        for i = 0, 3 do
            for j = 0, 9 do
                table.insert(water, love.graphics.newQuad(1 + j * (width + 2), 1 + i * (height + 2), width, height, image_width, image_height))
            end
        end

        return water

    elseif sprite == "tiles" then

        tiles = {}

        for i = 0, 1 do
            for j = 0, 10 do
                table.insert(tiles, love.graphics.newQuad(1 + j * (width + 2), 1 + i * (height + 2), width, height, image_width, image_height))
            end
        end

        return tiles
    
    elseif sprite == "key" then

        key = {}

        local maxFrames = 16

        for i = 0, 1 do
            for j = 0, 9 do
                table.insert(key, love.graphics.newQuad(1 + j * (width + 1), 1 + i * (height + 1), width, height, image_width, image_height))
                if #key == maxFrames then
                    break
                end
            end
        end

        return key
            
    end
end
