local game = require "game"

function love.load()
    game:load()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end

function love.resize(w, h)
    game:setWindowSize(w, h)
    game:calculateCanvasScale()
end
