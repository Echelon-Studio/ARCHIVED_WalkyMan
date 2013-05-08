function AI_Object(Type, PosX, PosY, MaxX, MaxY)
	local AI_Char = NewCharacter(Type, PosX, PosY)
	local handler = { }
	handler.AI_Char = AI_Char
	local MoveCount = 0
	local MoveDir = 0
	local MovePosition = {0, 0}
	local down = false
	local last_move_time = 0
	local Directions = {
		{[-1]="L", [1] = "R"},
		{[-1]="B", [1] = "F"}
	}
	
	function handler:SetMove(X, Y)
		MovePosition[1] = X
		MovePosition[2] = Y
	end
	function handler:Update(dt, running_time)
		if MovePosition[1]==AI_Char.x and MovePosition[2]==AI_Char.y then
			if down then
				down = false
				last_move_time = running_time
			end
			if running_time - last_move_time>2 then
				self:SetMove(math.random(MaxX), math.random(MaxY))
			end
		elseif MoveCount==0 and MovePosition[1]==AI_Char.x and not MovePosition[2]==AI_Char.y then
			down = true
			MoveDir = Clamp(MovePosition[2] - AI_Char.y)
			MoveCount = math.abs(MovePosition[2] - AI_Char.y)
			AI_Char:ChangeDirection(Directions[2][MoveDir])
			AI_Char:addPos(0, MoveDir)
		else
			if MovePosition[1]~=AI_Char.x then
				down = true
				MoveDir = Clamp(MovePosition[1] - AI_Char.x)
				MoveCount = math.abs(MovePosition[1] - AI_Char.x)
				AI_Char:ChangeDirection(Directions[1][MoveDir])
				AI_Char:addPos(MoveDir, 0)
			elseif MovePosition[2]~=AI_Char.y then
				down = true
				MoveDir = Clamp(MovePosition[2] - AI_Char.y)
				MoveCount = math.abs(MovePosition[2] - AI_Char.y)
				AI_Char:ChangeDirection(Directions[2][MoveDir])
				AI_Char:addPos(0, MoveDir)
			end
		end
		AI_Char:UpdateFace(down, dt)
	end
	return handler
end


				
			
				
			
	
	