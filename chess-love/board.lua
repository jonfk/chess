
local board = {}

local piece = require 'piece'
local inspect = require 'vendor.inspect'
local sprites = require 'sprites'

local boardMethods = {}

-- by default
-- draw board 480x480
-- offset by 160 on x-axis and 60 on y-axis
local gridSize, offsetX, offsetY, squareSize = 480,160,60,60

-- sprite scale factor
-- original sprite sheet size = 2000x667
-- sprite = 333.5x333.5
local scaleFactor = 0.18

function boardMethods:getPiece(x,y)
   return self.grid[y][x]
end

function boardMethods:placePiece(pie, x, y)
   if not piece.isPiece(pie) then
      error("Invalid argument to placePiece: "..pie)
   end
   self.grid[y][x] = pie
end

-- move piece from x1,y1 to x2,y2
function boardMethods:movePiece(x1,y1, x2,y2)
   if board.isValidGridPos(x1,y1) and board.isValidGridPos(x2,y2) then
      if self.grid[y1][x1] ~= 0 then
         print("moving piece "..x1..","..y1.." to "..x2..","..y2)
         self.grid[y2][x2] = self.grid[y1][x1]
         self.grid[y1][x1] = 0
      end
   end
end

function boardMethods:draw()
   love.graphics.clear()
   love.graphics.setColor(255, 255, 255)
   -- draw grid
   love.graphics.line(offsetX,offsetY, offsetX + gridSize,offsetY)
   love.graphics.line(offsetX,offsetY, offsetX,offsetY + gridSize)
   love.graphics.line(offsetX + gridSize,offsetY, offsetX + gridSize,offsetY + gridSize)
   love.graphics.line(offsetX,offsetY + gridSize, offsetX + gridSize,offsetY + gridSize)

   for i = offsetX,offsetX+gridSize,squareSize do
      love.graphics.line(i,offsetY, i,offsetY+gridSize)
   end
   for i = offsetY,offsetY+gridSize,squareSize do
      love.graphics.line(offsetX,i, offsetX+gridSize,i)
   end

   local i = 1
   local j = 1
   for y = offsetY, offsetY+gridSize-squareSize, squareSize do
      for x = offsetX, offsetX+gridSize-squareSize, squareSize do

         if (i % 2 == 0 and j % 2 ~= 0) or (i % 2 ~= 0 and j % 2 == 0) then
            love.graphics.setColor(255, 255, 255,255)
            love.graphics.rectangle('fill', x, y, squareSize, squareSize)
         else
            love.graphics.setColor(60, 60, 60)
            love.graphics.rectangle('fill', x, y, squareSize, squareSize)
         end
         i = i + 1
      end
      j = j + 1
   end

   -- Draw pieces
   for y = 1,8 do
      for x = 1,8 do
         if self.grid[y][x] ~= 0 then
            local xP, yP = board.gridToPixels(x, y)
            love.graphics.setColor(255, 0, 0)
            love.graphics.print(self.grid[y][x], xP, yP)
            self.spriteSheet:draw(self.grid[y][x], xP, yP, scaleFactor)
         end
      end
   end
end

-- to be called when windowWidth and windowHeight are initialized
function boardMethods:calculateBoardSizes()
   local minSize = min(self.windowWidth, self.windowHeight)
   print("min "..minSize)
   for a = minSize,0,-1 do
      print("a: "..a)
      if a % 8 == 0 then
         gridSize = a
         break
      end
   end
   offsetX = (self.windowWidth - gridSize) / 2
   offsetY = (self.windowHeight - gridSize) / 2
   squareSize = gridSize / 8
   print("Calculating Board Size from window size change")
   print("offsets x,y: "..offsetX..","..offsetY)
   print("sizes: grid: "..gridSize.."; square: "..squareSize)
   -- calculate scale factor
   scaleFactor = (100 / (333 / squareSize)) / 100
end

function boardMethods:init()
   initialGrid = {
      ["A8"] = piece.BlackRook,
      ["B8"] = piece.BlackKnight,
      ["C8"] = piece.BlackBishop,
      ["D8"]= piece.BlackQueen,
      ["E8"]= piece.BlackKing,
      ["F8"]= piece.BlackBishop,
      ["G8"]= piece.BlackKnight,
      ["H8"]= piece.BlackRook,
      ["A7"]= piece.BlackPawn,
      ["B7"]= piece.BlackPawn,
      ["C7"]= piece.BlackPawn,
      ["D7"]= piece.BlackPawn,
      ["E7"]= piece.BlackPawn,
      ["F7"]= piece.BlackPawn,
      ["G7"]= piece.BlackPawn,
      ["H7"]= piece.BlackPawn,
      ["A1"]= piece.WhiteRook,
      ["B1"]= piece.WhiteKnight,
      ["C1"]= piece.WhiteBishop,
      ["D1"]= piece.WhiteQueen,
      ["E1"]= piece.WhiteKing,
      ["F1"]= piece.WhiteBishop,
      ["G1"]= piece.WhiteKnight,
      ["H1"]= piece.WhiteRook,
      ["A2"]= piece.WhitePawn,
      ["B2"]= piece.WhitePawn,
      ["C2"]= piece.WhitePawn,
      ["D2"]= piece.WhitePawn,
      ["E2"]= piece.WhitePawn,
      ["F2"]= piece.WhitePawn,
      ["G2"]= piece.WhitePawn,
      ["H2"]= piece.WhitePawn
   }
   for y = 1,8 do
      self.grid[y] = {}
      for x = 1,8 do
         self.grid[y][x] = 0
      end
   end
   for k, pie in pairs(initialGrid) do
      local x,y = board.toXY(k)
      self:placePiece(pie, x,y)
   end
end

function boardMethods:debugPrint()
   for i, row  in ipairs(self.grid) do
      print(inspect(self.grid[i]))
   end
end


local Board = {__index = boardMethods}

function board.new(sheet, windowWidth, windowHeight)
   local b =  setmetatable({
         spriteSheet = sheet,
         windowHeight = windowHeight,
         windowWidth = windowWidth,
         grid = {}
                           }, Board)
   b:init()
   b:calculateBoardSizes()
   return b
end


-- Grid layout Helpers

function board.isValidGridPos(x,y)
   return x > 0 and x < 9 and y > 0 and y < 9
end

function board.gridToPixels(x,y)
   local xPixel = (offsetX - squareSize) + (x * squareSize)
   local yPixel = (offsetY - squareSize) + (y * squareSize)
   return xPixel, yPixel
end

function board.pixelsToGrid(x,y)
   if x < offsetX or x > (offsetX + gridSize) or y < offsetY or y > (offsetY + gridSize) then
      -- outside of grid
      return 0,0
   end
   local xG = math.floor((x - offsetX)/squareSize) + 1
   local yG = math.floor((y - offsetY)/squareSize) + 1
   return xG, yG
end

-- Algebriac Chess Notation to Grid Layout Helpers

-- a8 stands for 1,1
-- h1 stands for 8,8
--   a b c d e f g h
-- 8
-- 7
-- 6
-- 5
-- 4
-- 3
-- 2
-- 1

-- from plain x,y to algebraic chess notation (e.g. A8)
function board.toAG(x,y)
   if x < 1 or x > 8 or y < 1 or y > 8 then
      error("Invalid x,y grid position: "..tostring(x)..","..tostring(y))
   end
   local letter = string.format('%c', 64+x)
   local num = 9 - y
   return string.format('%s%d', letter, num)
end

-- from algebraic chess notation to plain x,y
function board.toXY(algN)
   assert(type(algN) == "string", "toXY expects a string of 2 characters. e.g. A8")
   if algN:len() ~= 2 then
      error("Invalid algebraic chess notation: "..algN)
   end
   local letter = algN:byte(1)
   local x = 0
   if letter >= 65 and letter <= 72 then
      x = letter - 64
   elseif letter >= 97 and letter <= 104 then
      x = letter - 96
   else
      error("Invalid algebraic chess notationl: "..algN)
   end

   local y = 0
   local num = tonumber(algN:sub(2))
   if num < 1 or num > 8 then
      error("Invalid algebraic chess notationn: "..algN)
   else
      y = 9 - num
   end

   -- debug TO REMOVE
   if x == 0 or y == 0 then
      error("Internal error, non-exhaustive matching")
   end
   return x,y
end

function min(x, y)
   if x > y then
      return y
   else
      return x
   end
end

return board
