local Character_Types = { }
local files = love.filesystem.enumerate("Images/Characters/")
for _, v in pairs(files) do
	Character_Types[_] = v
end
 local Character_Image_Labels = {
  ['RS'] = ("Images/Characters/CHAR/Right.png"),
   ['RR'] = ("Images/Characters/CHAR/RightRight.png"),
	['RL'] = ("Images/Characters/CHAR/RightLeft.png"),
  --   ['RS'] = ("Images/Characters/CHAR/Right.png"),
   ['LS'] = ("Images/Characters/CHAR/Left.png"),
	['LL'] = ("Images/Characters/CHAR/LeftLeft.png"),
  --    ['LS'] = ("Images/Characters/CHAR/Left.png"),
          ['LR'] = ("Images/Characters/CHAR/LeftRight.png"),
  ['FS'] = ("Images/Characters/CHAR/Front.png"),
                ['FR'] = ("Images/Characters/CHAR/FrontRight.png"),
                ['FL'] = ("Images/Characters/CHAR/FrontLeft.png"),
                ['BS'] = ("Images/Characters/CHAR/Back.png"),
                ['BR'] = ("Images/Characters/CHAR/BackRight.png"),
                ['BL'] = ("Images/Characters/CHAR/BackLeft.png")
            }

function NewCharacter(Type, PosX, PosY)
			local handler = { }
        local Character_Type = Type or math.random(#Character_Types)
		local Images = { }
		function handler:PreloadImages()
			Images = { }
			for _, v in pairs(Character_Image_Labels) do
				Images[_] = v:gsub("CHAR", Character_Types[Character_Type or 1])
			end
		end
	
		local face = 0;

		local faces = {
			[0] = "S",
			[1] = "R",
			[2] = "S",
			[3] = "L"
		}
		local Direction = "F"
        local Character = 'FS'
		local x = PosX or math.random(0, 500)
		local y = PosY or math.random(0, 500)
		handler.x = x
		handler.y = y
		handler.object = Images[Character]
		local space_checks = { }
		local update_time = 0;
		function handler:setChar(Char)
			Character = Char 
			handler.object = Images[Character]
			return Character
		end
		function handler:getChar()
			return Character
		end
		function handler:getImage()
			handler.object = Images[Character]
			return Images[Character]
		end
		function handler:UpdateFace(down, dt)
			if update_time + dt>=.25 and down then
				face = face + 1
				if face>3 then
					face = 0
				end
				update_time = 0
			elseif down then
				update_time = update_time + dt
			elseif not down then
				update_time = 0
				face = 0
			end
			Character = Direction .. faces[face]
			handler.object = Images[Character]
		end
		
		function handler:ChangeDirection(newdir)
			Direction = newdir
			Character = Direction .. faces[face]
			handler.object = Images[Character]
		end
		
		function handler:changeType(newType)
			local newType = newType or 1
			if newType>#Character_Image_Labels then
				newType = #Character_Image_Labels
			elseif newType<1 then
				newType = 1
			end
			Character_Type = newType
			self:PreloadImages()
			handler.object = Images[Character]
			return
		end
		function handler:setPos(X, Y)
			local X = X or 0
			local Y = Y or 0
			self.x, self.y = self:CheckPosition(X, Y)
			return self.x, self.y
		end
		function handler:getPos()
			return self.x, self.y
		end
		function handler:setChecker(func, func2, ind)
			local ind = ind or func
			space_checks[ind] = {func, func2}
		end
		function handler:removeChecker(ind)
			space_checks[ind] = nil
		end
		function handler:CheckPosition(X, Y)
			for _, v in pairs(space_checks) do
				if not v[1](X, Y) then return v[2](X, Y) end
			end
			return X, Y
		end
		function handler:addPos(X, Y)
			local X = X or 0
			local Y = Y or 0
			self.x, self.y = self:CheckPosition(self.x + X, self.y + Y)
			return self.x, self.y
		end
		handler:PreloadImages()
	return handler
end
		
			
		