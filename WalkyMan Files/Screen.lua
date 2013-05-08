function screen_object()
	local handler = { }
	handler.height = love.graphics.getHeight()
	handler.width = love.graphics.getWidth()
	handler.draw_stack = { }
	local index_stack = { }
	
	function handler:add_Object(object, index)
		index_stack[object] = {index}
	end
	
	function handler:remove_Object(object)
		index_stack[object] = nil
	end
	
	function handler:update_Stack()
		self.draw_stack = { }
		for i, v in pairs(index_stack) do
			local index = v[1] or i.y
			if self.draw_stack[index]==nil then
				self.draw_stack[index] = { }
			end
			self.draw_stack[index][v] = v
		end
	end

	return handler
end

	