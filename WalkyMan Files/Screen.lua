function screen_object()
	local handler = { }
	handler.height = love.graphics.getHeight()
	handler.width = love.graphics.getWidth()
	handler.draw_stack = { }
	handler.index_stack = { }
	
	function handler:add_Object(object, index)
		self.index_stack[index] = {index, object}
		self:sort_Stack()
	end
	
	function handler:sort_Stack()
		--[[
		table.sort(self.index_stack, function(t1, t2) 
			local c1;
			local c2;
			if t1[1] then 
				c1 = tonumber(t1[1])
			else 
				c1 = t1[2].y
			end
			if t2[1] then
				c2 = tonumber(t2[1])
			else
				c2 = t2[2].y
			end
		end)
		]]
	end
	
	--[[
	
	
	
	
	
		local index = index
		index = index or object.y
		self.index_stack[object] = {index}
		if self.draw_stack[(type(index)=='string' and tonumber(index) or index)]==nil then
			self.draw_stack[(type(index)=='string' and tonumber(index) or index)] = { }
		end
		self.draw_stack[(type(index)=='string' and tonumber(index) or index)][object] = object
		
	end]]
	
	function handler:remove_Object(object)
		self.index_stack[object] = nil
		self.draw_stack[index][object] = object
	end
	
	
	function handler:update_Stack(object)
	--	self.draw_stack = { }
	self:sort_Stack()
	--[[
		if object then
			local index = self.index_stack[object][1]
			if index~="string" then
				if self.draw_stack[index]~=nil then
					self.draw_stack[index][object] = nil
					if #self.draw_stack[index]==0 then
						self.draw_stack[index] = nil
					end
				end
				index = object.y
				if self.draw_stack[index]==nil then
					self.draw_stack[index] = { }
				end
				self.draw_stack[index][object] = object
			end
		]]
			--[[
		else
			for i, v in pairs(self.index_stack) do
				local index = v[1] or i.y
				if self.draw_stack[index]==nil then
					self.draw_stack[index] = { }
				end
				self.draw_stack[index][i] = i
			end
			
		end]]
	end

	return handler
end

	