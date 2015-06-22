
local board = {}

local piece = require 'piece'
local inspect = require 'vendor.inspect'

local boardMethods = {}

function boardMethods:getPiece(x,y)
   return self.grid[y][x]
end

function boardMethods:placePiece(pie, x, y)
   if not piece.isPiece(pie) then
      error("Invalid argument to placePiece: "..pie)
   end
   self.grid[y][x] = pie
end

function boardMethods:draw()
   love.graphics.setColor(255, 255, 255)
   -- draw board 480x480
   -- offset by 160 on x-axis and 60 on y-axis
   love.graphics.line(160,60, 640,60)
   love.graphics.line(160,60, 160,540)
   love.graphics.line(640,60, 640,540)
   love.graphics.line(160,540, 640,540)

   for i = 160,640,60 do
      love.graphics.line(i,60, i,540)
   end
   for i = 60,540,60 do
      love.graphics.line(160,i, 640,i)
   end

   local i = 1
   local j = 1
   for y = 60,480,60 do
      for x = 160,580,60 do

         if (i % 2 == 0 and j % 2 ~= 0) or (i % 2 ~= 0 and j % 2 == 0) then
            love.graphics.rectangle('fill', x, y, 60, 60)
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
         end
      end
   end

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
   print(inspect(self.grid))
end


local Board = {__index = boardMethods}

function board.new()
   local b =  setmetatable({grid = {}}, Board)
   b:init()
   return b
end


-- Grid layout Helpers

function board.gridToPixels(x,y)
   local xPixel = 100 + (x * 60)
   local yPixel = (y * 60)
   return xPixel, yPixel
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

return board
