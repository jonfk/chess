
local board = {}

local inspect = require 'vendor.inspect'

local boardMethods = {}

function boardMethods:getPiece()
end

function boardMethods:draw()
   -- draw board 480x480
   -- offset by 160 on x-axis and 60
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

end

function boardMethods:init()
   for y = 1,8 do
      self.grid[y] = {}
      for x = 1,8 do
         self.grid[y][x] = 0
      end
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
      error("Invalid algebraic chess notation: "..algN)
   end

   local y = 0
   local num = algN:byte(2)
   if num < 1 or num > 8 then
      error("Invalid algebraic chess notation: "..algN)
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
