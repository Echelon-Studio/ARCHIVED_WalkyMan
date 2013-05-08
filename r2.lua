require'drawing.lua'

function love.load()
	love.physics.setMeter(32)
	Physics_World = love.physics.newWorld(0, 0, true)
	ground = NewRectangle(
		{['Position'] = {
	
	