---@class map
local map = {
    cellSize = nil,
    cellsX = nil,
    cellsY = nil
}

function map:new(cellsX, cellsY, cellSize)
    local o = {}
    o.cellsX = cellsX or 20
    o.cellsY = cellsY or 20
    o.cellSize = cellSize or 20

    function o:draw()
        love.graphics.setColor(.4, .5, 1)
        love.graphics.rectangle("fill", 0, 0, self.cellsX * self.cellSize, self.cellsY * self.cellSize)
    end
    
    return o
end

return map
