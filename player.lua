Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "player.png")
    self.tile_x = x
    self.tile_y = y
end