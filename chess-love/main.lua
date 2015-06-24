
local board = require 'board'
local inspect = require 'vendor.inspect'
local piece = require 'piece'
local sprites = require 'sprites'

local selectedX, selectedY = 0,0

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

function love.mousepressed(x, y, button)
   if button == "l" then
      --print("pressed: "..x..", "..y)
      xG, yG = board.pixelsToGrid(x,y)
      --print("Grid: "..xG..", "..yG)
      --print("Current selected: "..selectedX..","..selectedY)
      if selectedX == 0 or selectedY == 0 then
         --print("select")
         selectedX = xG
         selectedY = yG
      elseif selectedX ~= xG or selectedY ~= yG then
         --print("move")
         chessboard:movePiece(selectedX, selectedY, xG,yG)
         chessboard:debugPrint()
         selectedX, selectedY = 0,0
      elseif selectedX == xG and selectedY == yG then
         selectedX, selectedY = 0,0
      end
   end
end
