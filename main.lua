local map = require "map"
local snake = require "snake"
local food = require  "food"
local gamemanager = require "gameManager"
local collisionManager = require "collisionManager"

io.stdout:setvbuf("no")

function love.load()
    Player = snake:new()
    Level = map:new(20, 20, 20)
end

function love.update()
    Player:update()

    if(collisionManager:collisionBetweenSnakeAndFood(Player, food)) then
        gamemanager.score = gamemanager.score + 1
        food:respawn()
        Player.hasEaten = true
    end
end

function love.draw()
    Level:draw()
    Player:draw()
    food:draw()

    love.graphics.setColor(1,1,1)
    love.graphics.print("Score: " .. tostring(gamemanager.score), 10, 450, 0, 2, 2, 0, 0, 0)
end
