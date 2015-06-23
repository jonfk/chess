
local sprites = {}

local piece = require 'piece'

local spritesMethods = {}

function spritesMethods:draw(pieceType, x, y)
   local quad
   if pieceType == piece.WhiteKing then
      quad = love.graphics.newQuad(0, 0, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.WhiteQueen then
      quad = love.graphics.newQuad(333.3, 0, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.WhiteBishop then
      quad = love.graphics.newQuad(666.6, 0, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.WhiteKnight then
      quad = love.graphics.newQuad(1000, 0, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.WhiteRook then
      quad = love.graphics.newQuad(1333.3, 0, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.WhitePawn then
      quad = love.graphics.newQuad(1666.6, 0, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.BlackKing then
      quad = love.graphics.newQuad(0, 333.3, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.BlackQueen then
      quad = love.graphics.newQuad(333.3, 333.3, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.BlackBishop then
      quad = love.graphics.newQuad(666.6, 333.3, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.BlackKnight then
      quad = love.graphics.newQuad(1000, 333.3, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.BlackRook then
      quad = love.graphics.newQuad(1333.3, 333.3, 333.3, 333.5, self.image:getDimensions())
   elseif pieceType == piece.BlackPawn then
      quad = love.graphics.newQuad(1666.6, 333.3, 333.3, 333.5, self.image:getDimensions())
   end
   love.graphics.setColor(255, 255, 255)
   love.graphics.draw(self.image ,quad ,x,y ,0, 0.18,0.18)
end

local Sprites = {__index = spritesMethods}

function sprites.new(img)
   print(img)
   local s = setmetatable({image = img}, Sprites)
   return s
end

return sprites
