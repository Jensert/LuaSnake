---@class food
local food = {
    position = {x=0, y=0}
}

function food:draw()
    love.graphics.setColor(0.9, 0.5, .6)
    love.graphics.rectangle("fill", self.position.x * Level.cellSize, self.position.y * Level.cellSize, Level.cellSize, Level.cellSize)
end

function food:respawn()
    self.position = {
        x = math.random(0, Level.cellsX),
        y = math.random(0, Level.cellsY)
    }
end

return food
