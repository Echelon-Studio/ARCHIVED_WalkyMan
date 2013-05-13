function newPrimitiveParticle(settings, screen)
	local object = settings.object
	if not object then return end
	local set = {
		['Color'] = settings.Color or {200, 200, 200},
		['Position'] = object.Position,
		['Index'] = settings.Index or 4,
		['Size'] = settings.Size or {7, 7},
		['Transparency'] = 0,
		['Interval'] = settings.Interval or .05
	}
	local handler = { }
	local last = 0
	function handler:Destroy()
		handler = nil
		self = nil
	end
	function handler:Update(dt)
		last = last + dt
		if not screen.index_stack[object] then
			handler:Destroy()
			return
		end
		if last>=set.Interval then
			local x;
			local y;
			x, y = object.Position[1], object.Position[2]
			local drop = NewRectangle({
				['Color'] = set.Color,
				['Size'] = {5, 5},
				['Position'] = {x + math.random(-5, 5), y + math.random(-5, 5)},
				['Physics'] = true,
				["Physics_Mode"] = "dynamic",
				['Index'] = set.Index,
				['Boundaries'] = function(object) return not (object.Position[1]>screen.width or object.Position[1]<0 or object.Position[2]>screen.height or object.Position[2]<0) end,
			}, screen)
			drop:setLifespan(1)
			drop:setUpdate(function(self, dt)
				if self.Update_Time==nil then
					self.Update_Time = 0
				end
				self.Update_Time = self.Update_Time + dt
				if self.Update_Time>.1 then
					self.Transparency = self.Transparency + .1
				end
				if self.Transparency>1 then
					self:Destroy()
				end
			end)
			local imp = math.random(-5, 5)
			imp = imp==0 and 1 or imp
			drop.Physics.body:applyLinearImpulse(math.random(-1, 1)/10, 0)
			drop.Physics.fixture:setRestitution(2)
		end
	end
	
end
	