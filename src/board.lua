
local board = {}

local boardMethods = {}

function boardMethods:getPiece()
end

function boardMethods:draw()
   love.graphics.line(150,50, 650,50)
   love.graphics.line(150,50, 150,550)
   love.graphics.line(650,50, 650,550)
   love.graphics.line(150,550, 650,550)

   for i = 150,650,62.5 do
      love.graphics.line(i,50, i,550)
   end
   for i = 50,550,62.5 do
      love.graphics.line(150,i, 650,i)
   end

   --[[
   local i = 1
   local j = 1
   for y = 50,550,62.5 do
      for x = 150,650,62.5 do

         if (i % 2 == 0 and j % 2 ~= 0) or (i % 2 ~= 0 and j % 2 == 0) then
            love.graphics.polygon('fill', x,y, x+62.5,y, x,y+62.5, x+62.5,y+62.5)
         end
         i = i + 1
      end
      j = j + 1
   end
   --]]

end


local Board = {__index = boardMethods}

function board.new()
   return setmetatable({}, Board)
end

return board
