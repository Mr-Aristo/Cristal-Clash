-- viewmodel.lua

local ViewModel = {}
ViewModel.__index = ViewModel

function ViewModel:new(model)
    local self = setmetatable({}, ViewModel)
    self.model = model
    return self
end

-- Get Table from model
function ViewModel:getBoard()
    return self.model:getBoard()  
end

-- Apply user movement
function ViewModel:makeMove(x, y, direction)
    local dx, dy = 0, 0
    if direction == "l" then dx, dy = 0, -1
    elseif direction == "r" then dx, dy = 0, 1
    elseif direction == "u" then dx, dy = -1, 0
    elseif direction == "d" then dx, dy = 1, 0
    else
        print("Invalid direction!")
        return
    end

    local nx, ny = x + dx, y + dy
    if nx >= 1 and nx <= self.model.size and ny >= 1 and ny <= self.model.size then
        self.model:move(x, y, nx, ny)
        self:processMatches()
    else
        print("Invalid move!")
    end
end

-- Check matches and apply 
function ViewModel:processMatches()
    local matches = self.model:findMatches()
    if #matches > 0 then
        self.model:applyMatches(matches)
    else
        print("There is no match!")
    end
end

return ViewModel
