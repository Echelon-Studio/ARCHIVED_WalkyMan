require("Screen")
require("Character")
require("Graphic")
require("AI")
local running_time = 0
love.graphics.setCaption("WalkyMan")
love.graphics.toggleFullscreen()
local Grass;
local Character;
local AIs = { };


function love.load()
screen = screen_object()
Character = NewCharacter(Type, PosX, PosY)
Character:setChecker(
	function(x, y)
		return x<screen.width and x>0
			and y<screen.height and y>0
	end, 
	function(x, y)
		local x = x
		local y = y
		if x>screen.width then 
			x = 0 
		elseif x<0 then 
			x = screen.width 
		end
		if y>screen.height then
			y = 0
		elseif y<0 then
			y = screen.height
		end
		return x, y
	end, 'boundaries')
screen:add_Object(Character, 3)
Grass = Graphics_Object("Images/Map/Grass.png")
screen:add_Object(Grass, "Background")
	for i=1, math.random(10, 20) do
		local ai = AI_Object(nil,nil,nil,screen.width, screen.height)
		AIs[#AIs+1] = ai
		ai.AI_Char:setChecker(
			function(x, y)
				return x<screen.width and x>0
					and y<screen.height and y>0
			end, 
			function(x, y)
				local x = x
				local y = y
				if x>screen.width then 
					x = 0 
				elseif x<0 then 
					x = screen.width 
				end
				if y>screen.height then
					y = 0
				elseif y<0 then
					y = screen.height
				end
				return x, y
			end, 'boundaries')
			ai:SetMove(math.random(screen.width), math.random(screen.height))
		screen:add_Object(ai.AI_Char, 3)
	end
	
end

local print_stack = { }
local print_stack_max = 10
local function print(...)
	local eched = ""
	for _, v in pairs({...}) do
		eched = eched .. " "..tostring(v)
	end
	for i=1, print_stack_max do
		print_stack[i] = (i==print_stack_max and eched or print_stack[i + 1])
	end
end
	
	
function love.draw()
     --   love.graphics.draw(Grass, 0, 0)
	 --[[
        love.graphics.draw(Images[Character], x, y)
        for _, v in pairs(others) do
            if v.Character then
                love.graphics.draw(love.graphics.newImage(Character_Image_Labels[v.char]:gsub("CHAR", v.type)), v.x, v.y)
            end
        end]]
		for _, v in pairs(screen.draw_stack) do
			for __, vv in pairs(v) do
				if type(vv.object)=="userdata" then
					love.graphics.draw(vv.object, vv.x, vv.y)
				end
			end
		end
	--	screen:sort_Stack()

		for _, v in pairs(print_stack) do
			love.graphics.print(v, 0, (_ - 1) * 10)
		end
end
print("Press ESC to exit")
--print("Press UP and DOWN to cycle characters.")
local down = false
local update_time = 0
local char_typer = 1

function Clamp(num)
	return math.abs(num)/num
end

function love.update(dt)
	--screen:update_Stack()
--	server_update_time = server_update_time + dt
	running_time = running_time + dt
    if love.keyboard.isDown("w") then
		Character:ChangeDirection("B")
		Character:addPos(0, -1)
		down = true
    elseif love.keyboard.isDown("s") then
		Character:ChangeDirection("F")
		Character:addPos(0, 1)
		down = true
    elseif love.keyboard.isDown("a") then
		Character:ChangeDirection("L")
		Character:addPos(-1, 0)
		down = true
    elseif love.keyboard.isDown("d") then
		Character:ChangeDirection("R")
		Character:addPos(1, 0)
		down = true
	elseif love.keyboard.isDown("escape") then
		love.event.quit()
    else
		down = false
    end
	Character:UpdateFace(down, dt)
	for _, v in pairs(AIs) do
		v:Update(dt, running_time)
	end
end