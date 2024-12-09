---@class collisionManager
local collisionManager = {}

---@param snake snake
---@param food food
function collisionManager:collisionBetweenSnakeAndFood(snake, food)
    if snake.segments[1].x == food.position.x and snake.segments[1].y == food.position.y and not snake.hasEaten then
        return true
    end
end

return collisionManager
