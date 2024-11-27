-- view.lua

local View = {}

-- Displaying game board
function View:displayBoard(board)
    for i = 1, #board do
        for j = 1, #board[i] do
            io.write(board[i][j] or ' ', " ")
        end
        print()
    end
end

return View
