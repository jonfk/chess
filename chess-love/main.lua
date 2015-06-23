
local board = require 'board'
local inspect = require 'vendor.inspect'
local piece = require 'piece'
local sprites = require 'sprites'

function love.load()
   spriteSheet = love.graphics.newImage("assets/Chess_Pieces_Sprite.svg.png")
   sheet = sprites.new(spriteSheet)
   chessboard = board.new(sheet)
   chessboard:debugPrint()
end

function love.draw()
   chessboard:draw()
   love.graphics.setColor(255, 255, 255)
end

function love.update(dt)
end
