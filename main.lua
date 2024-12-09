local map = require "map"
local snake = require "snake"
local food = require  "food"
local gamemanager = require "gameManager"
local collisionManager = require "collisionManager"

io.stdout:setvbuf("no")

local Game = {
    ---@type snake
    player = nil,
    ---@type map
    map = nil,
}

function Game:load()
    self.player = snake:new()
    self.map = map:new(20, 20, 20)
end

function Game:update()
    self.player:update()
    if(collisionManager:collisionBetweenSnakeAndFood(self.player, food)) then
        gamemanager.score = gamemanager.score + 1
        food:respawn(self.map)
        self.player.hasEaten = true
    end
end

function Game:draw()
    self.map:draw()
    self.player:draw(self.map)
    food:draw(self.map)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Score: " .. tostring(gamemanager.score), 10, 450, 0, 2, 2, 0, 0, 0)
end

function love.load()
    Game:load()
end

function love.update()
    Game:update()
end

function love.draw()
    Game:draw()
end
