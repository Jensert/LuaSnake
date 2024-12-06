Food = {
    position = {x=0, y=0}
}

function Food:draw()
    love.graphics.setColor(0.9, 0.5, .6)
    love.graphics.rectangle("fill", self.position.x * Level.cellSize, self.position.y * Level.cellSize, Level.cellSize, Level.cellSize)
end
