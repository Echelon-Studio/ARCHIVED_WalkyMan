local running_time = 0
function love.load()
        Images = {
            ['RS'] = love.graphics.newImage("Images/Red/Right.png"),
            ['RR'] = love.graphics.newImage("Images/Red/RightRight.png"),
--            ['RL'] = love.graphics.newImage("Images/Red/RightLeft.png"),
            ['RL'] = love.graphics.newImage("Images/Red/Right.png"),
            ['LS'] = love.graphics.newImage("Images/Red/Left.png"),
--            ['LL'] = love.graphics.newImage("Images/Red/LeftLeft.png"),
            ['LL'] = love.graphics.newImage("Images/Red/Left.png"),
            ['LR'] = love.graphics.newImage("Images/Red/LeftRight.png"),
            ['FS'] = love.graphics.newImage("Images/Red/Front.png"),
            ['FR'] = love.graphics.newImage("Images/Red/FrontRight.png"),
            ['FL'] = love.graphics.newImage("Images/Red/FrontLeft.png"),
            ['BS'] = love.graphics.newImage("Images/Red/Back.png"),
            ['BR'] = love.graphics.newImage("Images/Red/BackRight.png"),
            ['BL'] = love.graphics.newImage("Images/Red/BackLeft.png")
        }
        Character = 'FS'
        x = 100
        y = 100
end
function love.draw()
        love.graphics.draw(Images[Character], x, y)
		love.graphics.print(love.graphics.getWidth() .. "", 50, 50)
		love.graphics.print(love.graphics.getHeight() .. "", 50, 100)
end
local down = false
local face = 0;
local update_time = 0
 local faces = {
        [0] = "S",
        [1] = "R",
        [2] = "L"
    }

function love.update(dt)
        running_time = running_time + dt
        if update_time + dt>=.4 and down then
            face = face + 1
            if face>2 then
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
        elseif love.keyboard.isDown("s") then
                y = y + 1
                Character = "F" .. faces[face]
                down = true
        elseif love.keyboard.isDown("a") then
                x = x - 1
                Character = "L" .. faces[face]
                down = true

        elseif love.keyboard.isDown("d") then
                x = x + 1
                Character = "R" .. faces[face]
                down = true
        else
            down = false
			Character = Character:sub(1, 1) .. faces[0]
        end
end
