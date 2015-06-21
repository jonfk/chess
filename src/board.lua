
local board = {}

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


local Board = {__index = boardMethods}

function board.new()
   return setmetatable({}, Board)
end

return board
