require("snake")
require("map")
require("food")
require("gameManager")

io.stdout:setvbuf("no")



function love.load()
    Player = Snake:new()
    Level = Map:new(20, 20, 20)
end

function love.update()
    Player:update()

    if Player.segments[1].x == Food.position.x and Player.segments[1].y == Food.position.y and not Player.hasEaten then
        GameManager.score = GameManager.score + 1
        Food:respawn()
    end
end

function love.draw()
    Level:draw()
    Player:draw()
    Food:draw()

    love.graphics.setColor(1,1,1)
    love.graphics.print("Score: " .. tostring(GameManager.score), 10, 450, 0, 2, 2, 0, 0, 0)
end
