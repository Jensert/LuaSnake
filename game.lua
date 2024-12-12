local map = require "map"
local snake = require "snake"
local food = require  "food"
local gamemanager = require "gameManager"
local collisionManager = require "collisionManager"

io.stdout:setvbuf("no")

local game = {
    ---@type snake
    player = nil,
    ---@type map
    map = nil,

    window_width = nil,
    window_height = nil,

    canvas = nil,
    canvas_width = nil,
    canvas_height = nil,
    canvas_scale = {x = nil, y = nil},

    font_size = 120
}

function game:calculateCanvasScale()
    local sX = self.window_width / self.canvas_width
    local sY = self.window_height / self.canvas_height
    self.canvas_scale = {x = sX, y = sY}
end

---@param w? number Optional - width of the window
---@param h? number Optional - height of the window
function game:setWindowSize(w, h)
    self.window_width = w or love.graphics.getWidth()
    self.window_height = h or love.graphics.getHeight()
end

---@param w? number Optional - width of the canvas size
---@param h? number Optional - height of the canvas
function game:setCanvasSize(w, h)
    self.canvas_width = w or self.canvas.getWidth(self.canvas)
    self.canvas_height = h or self.canvas.getHeight(self.canvas)
end

function game:getFontScale()
    return 12 / self.font_size
end

function game:load()
    love.window.setTitle("Snake")
    love.window.setMode(640, 360, {resizable=true})
    love.graphics.setDefaultFilter("nearest", "nearest")

    game:setWindowSize(love.graphics.getWidth(), love.graphics.getHeight())

    self.canvas = love.graphics.newCanvas(32*20, 18*20)
    self:setCanvasSize()
    self:calculateCanvasScale()

    love.graphics.setFont(love.graphics.newFont(self.font_size))

    self.player = snake:new()
    self.map = map:new(32, 18, 20)
end

function game:update(dt)
    self.player:update(self.map)
    
    if(collisionManager:collisionBetweenSnakeAndFood(self.player, food)) then
        gamemanager.score = gamemanager.score + 1
        food:respawn(self.map)
        self.player.hasEaten = true
    end
end

function game:draw()
    -- Render everything to canvas
    love.graphics.setCanvas(game.canvas)

        self.map:draw()
        self.player:draw(self.map)
        food:draw(self.map)
        love.graphics.setColor(1,1,1)

        game:drawText()

    love.graphics.setCanvas()
    

    -- Draw the canvas
    love.graphics.draw(game.canvas, 0, 0, 0, game.canvas_scale.x, game.canvas_scale.y)
end

---@param sX? number X scaling factor 
---@param sY? number Y scaling factor
function game:drawText(sX, sY)
    love.graphics.push()
    love.graphics.scale(sX or self:getFontScale(), sY or self:getFontScale())
    love.graphics.print("Score: " .. tostring(gamemanager.score), 5/self:getFontScale(), 330/self:getFontScale(), 0, 2, 2)
    love.graphics.pop()
end

return game
