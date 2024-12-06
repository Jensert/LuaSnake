Snake = {
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

function Snake:getDirection()
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

function Snake:move()
    table.insert(self.segments, 1, {x = self.segments[1].x + self.direction.x, y = self.segments[1].y + self.direction.y})
    table.remove(self.segments, 4)
    
end

function Snake:update()
    self.timeSinceLastMovement = self.timeSinceLastMovement + love.timer.getDelta()

    self:getDirection()

    if self.timeSinceLastMovement >= 0.2 then
        self.timeSinceLastMovement = 0
        self.hasEaten = false
        self:move()
    end
end

function Snake:draw()
    for _segmentBlock, segment in ipairs(self.segments) do
        love.graphics.setColor(.2, .8, .4)
        love.graphics.rectangle("fill", segment.x * Level.cellSize, segment.y * Level.cellSize, Level.cellSize, Level.cellSize)
    end
end

function Snake:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end
