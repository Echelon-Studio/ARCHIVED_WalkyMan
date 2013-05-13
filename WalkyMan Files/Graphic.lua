function Graphics_Object(Image, PosX, PosY, screen)
	local handler = { }
	handler.x = PosX or 0
	handler.y = PosY or 0
	handler.object = love.graphics.newImage(Image)
	handler.Type = "Graphic"
	local space_checks = { }
	
	function handler:getImage()
		return Image
	end
		function handler:setPos(X, Y)
			local X = X or 0
			local Y = Y or 0
			self.x, self.y = self:CheckPosition(X, Y)
			screen:update_Stack(self)
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
--			screen:update_Stack(self)
			return self.x, self.y
		end
	screen:add_Object(object)
	return handler
end
