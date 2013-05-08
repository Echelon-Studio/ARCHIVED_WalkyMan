local drawings = { }
for i=1, 10 do
	drawings[i] = { }
end

function NewRectangle(settings)
	local index = settings.Index or 1
	index = (index>10 and 10 or index)
	local object = { 
		["Position"] = settings.Position or {0, 0},
		["Size"] = settings.Size or {0, 0},
		["Physics_Mode"] = settings.Physics_Mode or "static",
		["Color"] = settings.Color or {255, 255, 255},
		["Index"] = index
	}
	for _, v in pairs(settings) do
		object[_] = v
	end
	if object.Physics_stuff==true then
		object.Physics_stuff = { }
		object.Physics_stuff.body = love.physics.newBody(Physics_World, object.Position[1] - (object.Size[1]/2), object.Position[2] - (object.Size[2]/2), object.Physics_Mode)
		object.Physics_stuff.shape =  love.physics.newRectangleShape(object.Size[1], object.Size[2])
		object.Physics_stuff.fixture = love.physics.newFixture(object.Physics_stuff.body, object.Physics_stuff.shape)
	end
	drawings[index][object] = object
	return object
end
