require "laser"
require "window"
require "game"

function love.load()
    window_getMode()
    laser_init()
end

function love.update()
    game_update()
end

function love.draw()
   game_draw()
end