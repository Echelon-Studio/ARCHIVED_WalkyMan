function new_Text(text, settings, screen)
	local object = {
		['Text'] = text,
		['Position'] = type(settings.Position)=='table' and settings.Position or {0, 0},
		['Color'] = type(settings.Color)=='table' and settings.Color or {255, 255, 255},
		['Transparency'] = settings.Transparency or 0,
		['Size'] = type(settings.Size)=='table' and settings.Size or {0, 0},
		['Index'] = settings.Index or 'Text',
		['Rotation'] = settings.Rotation or 0,
		['Font'] = (type(settings.Font)~='string' and type(settings.Font)~='nil') and settings.Font or love.graphics.newFont(settings.Font, settings.fontSize or 12),
		['fontSize'] = settings.fontSize or 12,
		['Type'] = 'Text',
		['Update_Func'] = settings.Update_Func,
		['update_time'] = 0
	}
	
	function object:Destroy()
		screen:remove_Object(object)
		object = nil
		self = nil
	end

	local update_time = 0
	local update_func;
	function object:Update(dt)
		if type(self.Update_Func)=="function" then
			self:Update_Func(dt)
		end
	end
	
	function object:setUpdateFunc(func)
		self.Update_Func = func
	end
	
	screen:add_Object(object, object.Index)
	
	return object
end
