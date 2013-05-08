function screen_object()
	local handler = { }
	handler.height = love.graphics.getHeight()
	handler.width = love.graphics.getWidth()
	handler.draw_stack = { }
	local index_stack = { }
	
	function handler:add_Object(object, index)
		local index = index or object.y
		index_stack[object] = index
		self:update_Stack()
	end
	---------------
	function handler:add_Object(object, index)
		local index = index or object.y
		if self.draw_stack[index]==nil then
			handler.draw_stack[index] = { }
		end
		self.draw_stack[index][object] = object
		return
	end
	function handler:update_Object(object)
	function handler:remove_Object(object, index)
		local index = index or object.y
		self.draw_stack[index][object] = nil
		return
	end
	return handler
end

	