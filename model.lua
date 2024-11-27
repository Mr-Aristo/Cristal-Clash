-- model.lua

local Model = {}
Model.__index = Model

function Model:new(size)
    local self = setmetatable({}, Model)
    self.size = size or 10  
    self.board = {}  
    return self
end

-- Fill the board with random values between A-F 
function Model:init()
    for i = 1, self.size do
        self.board[i] = {}
        for j = 1, self.size do
            
            self.board[i][j] = string.char(math.random(65, 70))  -- between 'A' (65)  'F' (70) 
            --65 → 'A' 66 → 'B' 67 → 'C' 68 → 'D' 69 → 'E' 70 → 'F
        end
    end
end

-- Get board
function Model:getBoard()
    return self.board
end

-- Change position of the stones
function Model:move(x1, y1, x2, y2)
    self.board[x2][y2], self.board[x1][y1] = self.board[x1][y1], self.board[x2][y2]
end

-- Check the position matches 
function Model:findMatches()
    local matches = {}
    
    -- Horizontal matches
    for i = 1, self.size do
        for j = 1, self.size - 2 do
            if self.board[i][j] == self.board[i][j + 1] and self.board[i][j] == self.board[i][j + 2] then
                table.insert(matches, {i, j, i, j + 1, i, j + 2})  
            end
        end
    end

    -- Vertical matches
    for i = 1, self.size - 2 do
        for j = 1, self.size do
            if self.board[i][j] == self.board[i + 1][j] and self.board[i][j] == self.board[i + 2][j] then
                table.insert(matches, {i, j, i + 1, j, i + 2, j})  
            end
        end
    end
    
    return matches
end

-- Apply Matches and clean the board
function Model:applyMatches(matches)
    for _, match in ipairs(matches) do
        for i = 1, #match, 2 do
            local x, y = match[i], match[i + 1]
            self.board[x][y] = nil  -- Clean stones which matched
        end
    end
    self:dropAndFillBoard()
end

-- Fill the empty spaces and update the table
function Model:dropAndFillBoard()
    -- Slide down horizontal stones 
    for j = 1, self.size do
        local emptySpaces = {}
        for i = 1, self.size do
            if not self.board[i][j] then
                table.insert(emptySpaces, i)
            end
        end
        -- Put stone where the empty place is. 
        for _, empty in ipairs(emptySpaces) do
            self.board[empty][j] = string.char(math.random(65, 70))  
        end
    end
end

return Model
