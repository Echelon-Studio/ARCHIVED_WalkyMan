local running_time = 0
local socket = require("socket")
love.graphics.setCaption("WalkyMan")
love.graphics.toggleFullscreen()
local address =  "localhost"--"208.124.76.128"
local port = 54322
local entity;
local others = { }
local data;
local msg;
function love.load()
        udp = socket.udp()
        udp:settimeout(0)
        udp:setpeername(address, port)
     --   Grass = love.graphics.newImage("Images/Map/Grass.png")
            Character_Image_Labels = {
                ['RS'] = ("Images/CHAR/Right.png"),
                ['RR'] = ("Images/CHAR/RightRight.png"),
                                ['RL'] = ("Images/CHAR/RightLeft.png"),
                ['RS'] = ("Images/CHAR/Right.png"),
                ['LS'] = ("Images/CHAR/Left.png"),
                                ['LL'] = ("Images/CHAR/LeftLeft.png"),
                ['LS'] = ("Images/CHAR/Left.png"),
                ['LR'] = ("Images/CHAR/LeftRight.png"),
                ['FS'] = ("Images/CHAR/Front.png"),
                ['FR'] = ("Images/CHAR/FrontRight.png"),
                ['FL'] = ("Images/CHAR/FrontLeft.png"),
                ['BS'] = ("Images/CHAR/Back.png"),
                ['BR'] = ("Images/CHAR/BackRight.png"),
                ['BL'] = ("Images/CHAR/BackLeft.png")
            }
        Character_Types = {
            "Red",
            "Blue",
            "Nxt"
        }
        Character_Type = math.random(#Character_Types)
        Images = { }
        for _, v in pairs(Character_Image_Labels) do
            Images[_] = love.graphics.newImage(v:gsub("CHAR", Character_Types[Character_Type]))
        end
        Character = 'FS'
        x = math.random(300)
        y = math.random(300)
        udp:send("newentityid")
        local timeout = 0
     --   udp:settimeout(1)
	  
          --  data, msg = udp:receive()

      --  if timeout>=50 then error("timed out") end
	--	if entity then error("YAY ENTITY " .. entity) end
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
        love.graphics.draw(Images[Character], x, y)
        for _, v in pairs(others) do
            if v.Character then
                love.graphics.draw(love.graphics.newImage(Character_Image_Labels[v.char]:gsub("CHAR", v.type)), v.x, v.y)
            end
        end
		for _, v in pairs(print_stack) do
			love.graphics.print(v, 50, _ * 10)
		end
end
local down = false
local face = 0;
local update_time = 0
 local faces = {
        [0] = "S",
        [1] = "R",
                [2] = "S",
        [3] = "L",
                [4] = "S"
    }
local server_update_time = 0
local last_update = os.clock()
local function Upload_Updates()
	if os.clock()-last_update<.2 then return end
	if entity then
		udp:send("char for "..entity.." is "..tostring(Character))
		udp:send("position for "..entity.." is "..tostring(x).." and "..tostring(y))
		udp:send("type for "..entity.." is "..tostring(Character_Type))
		last_update = os.clock()
	end
end

function love.update(dt)
        server_update_time = server_update_time + dt
        running_time = running_time + dt
        if update_time + dt>=.25 and down then
            face = face + 1
            if face>4 then
                face = 1
            end
            update_time = 0
        elseif down then
            update_time = update_time + dt
        elseif not down then
            update_time = 0
            face = 0
        end
            
        if love.keyboard.isDown("w") then
                y = y - 1
                Character = "B" .. faces[face]
                down = true
				Upload_Updates()
        elseif love.keyboard.isDown("s") then
                y = y + 1
                Character = "F" .. faces[face]
                down = true
				Upload_Updates()
        elseif love.keyboard.isDown("a") then
                x = x - 1
                Character = "L" .. faces[face]
                down = true
                Upload_Updates()
        elseif love.keyboard.isDown("d") then
            x = x + 1
            Character = "R" .. faces[face]
            down = true
			Upload_Updates()
		elseif love.keyboard.isDown("escape") then
			love.event.quit()
        else
            down = false
			if Character==Character:sub(1, 1) .. faces[0] then
			
			else
				Character = Character:sub(1, 1) .. faces[0]
				Upload_Updates()
			end
        end
     -- if server_update_time>=.125 then
		print(Character, x, y, Character_Type, entity, os.clock())
		--[[
		if entity then
			udp:send("char for "..entity.." is "..tostring(Character))
			udp:send("position for "..entity.." is "..tostring(x).." and "..tostring(y).." WORK RIGHT YOU NIGGER")
			udp:send("type for "..entity.." is "..tostring(Character_Type))
		end
		]]
           -- server_update_time = server_update_time - dt
		
                data, msg = udp:receive()
                if data then
				    if data:match("([%w%p]+)%.*")=="entityid" then
						entity = data:sub(#('entityid ')+1)
						--error("Got entity: "..tostring(entity))
					elseif data:match("([%w%p]+)%s%.*")=="schar" then
						others[data:match("[%w%p]+%sfor%s([%w%p]+)%sis")]['char'] = data:match("[%w%p]+%sfor%s[%w%p]+%sis%s([%w%p]+)%s*")
					elseif data:match("([%w%p]+)%s%.*")=="sposition" then
						local enty;
						local x;
						local y;
						enty, x, y = data:match("[%w%s]+%sfor%s(%d+)%sis%s(%-?%d+%.?%d*)%sand%s(%-?%d+%.?%d*)")
						others[enty]['x'] = x
						others[enty]['y'] = y
						--[[
						others[data:match("[%w%p]+%sfor%s([%w%p]+)%sis")]['x'] = data:match("[%w%p]+%sfor%s[%w%p]+%sis%s([%w%p]+)%sand")
						others[data:match("[%w%p]+%sfor%s([%w%p]+)%sis")]['y'] = data:match("[%w%p]+%sfor%s[%w%p]+%sis%s[%w%p]+%sand%s([%w%p]+)")
						]]
					elseif data:match("([%w%p]+)%s%.*")=="stype" then
						others[data:match("[%w%p]+%sfor%s([%w%p]+)%sis")]['type'] = data:match("[%w%p]+%sfor%s[%w%p]+%sis%s([%w%p]+)%s*")
					end
					--[[
                    if data:match("(%S)+%s%.*")=="cu" then
                        local count = 1
                        local ent;
                        for k in gmatch("%s(%S+)%s*") do
                            if count==1 then
                                others[k] = { }
                                ent = k
                            elseif count==2 then
                                others[ent]['x'] = tonumber(k)
                            elseif count==3 then
                                others[ent]['y'] = tonumber(k)
                            elseif count==4 then
                                others[ent]['type'] = k
                            elseif count==5 then
                                others[ent]['char'] = k
                            end
                            count = count + 1
                        end
                    end]]
                end
       -- end
end
