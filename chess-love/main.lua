
local board = require 'board'
local inspect = require 'vendor.inspect'

function love.load()
   chessboard = board.new()
   chessboard:debugPrint()
end

function love.draw()
   chessboard:draw()
end

function love.update(dt)
end
