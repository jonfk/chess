
local board = require 'board'

function love.load()
   chessboard = board.new()
end

function love.draw()
   chessboard:draw()
end

function love.update(dt)
end
