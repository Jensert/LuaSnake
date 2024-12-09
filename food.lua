---@class food
local food = {
    position = {x=0, y=0}
}

---@param map map
function food:draw(map)
    love.graphics.setColor(0.9, 0.5, .6)
    love.graphics.rectangle("fill", self.position.x * map.cellSize, self.position.y * map.cellSize, map.cellSize, map.cellSize)
end

---@param map map
function food:respawn(map)
    self.position = {
        x = math.random(0, map.cellsX),
        y = math.random(0, map.cellsY)
    }
end

return food
