---@class snake
local snake = {
    segments = {    
        {x=2, y=0},
        {x=1, y=0},
        {x=0, y=0},
    },
    length = 3,
    direction = {x=1, y=0},
    timeSinceLastMovement = 0,
    hasEaten = false,
}

function snake:getDirection()
    if love.keyboard.isDown("right") and self.direction.x ~=-1 then
        self.direction = {x=1, y=0}
    end
    if love.keyboard.isDown("left") and self.direction.x ~= 1 then
        self.direction = {x=-1, y=0}
    end
    if love.keyboard.isDown("down") and self.direction.y ~= -1 then
        self.direction = {x=0, y=1}
    end
    if love.keyboard.isDown("up") and self.direction.y ~= 1 then
        self.direction = {x=0, y=-1}
    end
end

function snake:move()
    table.insert(self.segments, 1, {x = self.segments[1].x + self.direction.x, y = self.segments[1].y + self.direction.y})
    if not self.hasEaten then
        table.remove(self.segments, self.length+1)
    else
        self.length = self.length + 1
        self.hasEaten = false
    end
end

function snake:update()
    self.timeSinceLastMovement = self.timeSinceLastMovement + love.timer.getDelta()

    self:getDirection()

    if self.timeSinceLastMovement >= 0.2 then
        self.timeSinceLastMovement = 0
        self:move()
    end
end

function snake:draw()
    for _segmentBlock, segment in ipairs(self.segments) do
        love.graphics.setColor(.2, .8, .4)
        love.graphics.rectangle("fill", segment.x * Level.cellSize, segment.y * Level.cellSize, Level.cellSize, Level.cellSize)
    end
end

function snake:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

return snake
