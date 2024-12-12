---@class snake
local snake = {
    segments = {    
        {x=2, y=0},
        {x=1, y=0},
        {x=0, y=0},
    },
    length = 3,
    direction = {x=1, y=0},
    moveDelay = 0.2,
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

---@param map map
function snake:move(map)
    table.insert(self.segments, 1, {x = self.segments[1].x + self.direction.x, y = self.segments[1].y + self.direction.y})
    if not self.hasEaten then
        table.remove(self.segments, self.length+1)
    else
        self.length = self.length + 1
        self.hasEaten = false
        print(self.length)
    end
    snake:checkMapBoundaries(map)
end

---@param map map
function snake:checkMapBoundaries(map)
    if self.segments[1].x > (map.cellsX-1) then -- right bounds
        self.segments[1].x = 0
    end
    if self.segments[1].x < (0) then -- right bounds
        self.segments[1].x = map.cellsX
    end
    if self.segments[1].y > (map.cellsY-1) then -- right bounds
        self.segments[1].y = 0
    end
    if self.segments[1].y < (0) then -- right bounds
        self.segments[1].y = map.cellsY
    end
end

function snake:snakeCollision()
    for _segmentBlock, segment in ipairs(self.segments) do
        if segment.x == self.segments[1].x and segment.y == self.segments[1].y and segment ~= self.segments[1] then
                print("Snake collision detected")
                return true
        end
    end
end

function snake:update(map)
    self.timeSinceLastMovement = self.timeSinceLastMovement + love.timer.getDelta()

    self:getDirection()

    if self.timeSinceLastMovement >= self.moveDelay then
        self.timeSinceLastMovement = 0
        self:move(map)
    end

    
end

---@param map map
function snake:draw(map)
    for _segmentBlock, segment in ipairs(self.segments) do
        love.graphics.setColor(.2, .8, .4)
        love.graphics.rectangle("fill", segment.x * map.cellSize, segment.y * map.cellSize, map.cellSize, map.cellSize)
    end
end

function snake:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

return snake
