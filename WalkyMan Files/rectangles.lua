function NewRectangle(settings, screen)
	local index = settings.Index or 3
	local Physics = settings.Physics
	local object = { 
		["Position"] = settings.Position or {0, 0},
		["Size"] = settings.Size or {0, 0},
		["Physics_Mode"] = settings.Physics_Mode or "static",
		["Color"] = settings.Color or {255, 255, 255},
		["Index"] = index,
		["Boundaries"] = settings.Boundaries,
		["Type"] = settings.Type or "Rectangle"
	}
	for _, v in pairs(settings) do
		object[_] = v
	end
	if Physics==true then
		object.Physics = { }
		object.Physics.body = love.physics.newBody(Physics_World, object.Position[1] - (object.Size[1]/2), object.Position[2] - (object.Size[2]/2), object.Physics_Mode)
		object.Physics.shape =  love.physics.newRectangleShape(object.Size[1], object.Size[2])
		object.Physics.fixture = love.physics.newFixture(object.Physics.body, object.Physics.shape)
	end
	
	function object:Destroy()
		screen:remove_Object(self)
		object = nil
		self = nil
	end

	function object:setUpdateFunc(func)
		self.Update_Func = func
	end
	
	function object:Update(dt)
		if type(self.Update_Func)=="function" then
			self:Update_Func(dt)
		end
		if self.Span then
			self.Span = self.Span - dt
			if self.Span<0 then
				self:Destroy()
			end
		end
		if Physics then
			self.Position = {self.Physics.body:getX(), self.Physics.body:getY()}
		end
		if type(self.Boundaries)=='function' then
			if not self:Boundaries() then
				self:Destroy()
			end
		end
	end
	
	function object:setLifespan(span)
		self.Span = span
	end

	screen:add_Object(object, object.Index)
	return object
end
