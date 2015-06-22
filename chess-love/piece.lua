
local piece = {
   WhiteKing = 1,
   WhiteQueen = 2,
   WhiteRook = 3,
   WhiteBishop = 4,
   WhiteKnight = 5,
   WhitePawn = 6,
   BlackKing = 7,
   BlackQueen = 8,
   BlackRook = 9,
   BlackBishop = 10,
   BlackKnight = 11,
   BlackPawn = 12,
}

function piece.isPiece(x)
   return (x >= 1 and x <=12)
end

local pieceMethods = {}

local Piece = {__index = pieceMethods}

return piece
