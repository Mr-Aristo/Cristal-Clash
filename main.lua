-- main.lua

local Model = require("model")
local ViewModel = require("viewmodel")
local View = require("view")

-- Start point 
local model = Model:new(10)
local viewModel = ViewModel:new(model)
local view = View

model:init()
view:displayBoard(viewModel:getBoard())

while true do
    print("Insert movement positions (x, y, d) or for quit q:")
    local input = io.read()
    if input == "q" then
        break
    end

    local x, y, direction = input:match("(%d) (%d) (%a)")
    if x and y and direction then
        viewModel:makeMove(tonumber(x), tonumber(y), direction)
        view:displayBoard(viewModel:getBoard())
    else
        print("Invalid input")
    end
end
