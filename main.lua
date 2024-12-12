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

function love.keypressed(key)
    game:processInput(key, "pressed")
end

function love.keyreleased(key)
    game:processInput(key, "released")
end

function love.resize(w, h)
    game:setWindowSize(w, h)
    game:calculateCanvasScale()
end
