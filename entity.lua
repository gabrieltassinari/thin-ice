Entity = Object:extend()

function Entity:new(x, y, image_path)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(image_path)
end

function Entity:draw()
    love.graphics.draw(self.image, self.x, self,y)
end
