-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

t=0
x=96
y=24
DEFAULT_OBSTACLE_Y=-460

function init()
	obstacles={}
	for i=0, 4 do
		obstacles[i]=createObstacle(DEFAULT_OBSTACLE_Y+i*100)
	end
end	

function createObstacle(yValue)
	obstaclesTemp={}
	for i=0, 7 do
		obstaclesTemp[i]={x=24+24*i , y=yValue}
	end

	return obstaclesTemp
end

function updateObstacles()
	for i=0, 4 do
		for j=0, 7 do
			if obstacles[i][j].y==260 then
				obstacles[i][j].y=-260 --TODO
			else
				obstacles[i][j].y=obstacles[i][j].y+1
			end
		end
	end
end

function drawObstacles()
	for i=0, 4 do
		for j=0, 7 do
			spr(5,obstacles[i][j].x,obstacles[i][j].y,-1,3,0,0,1,1)
		end
	end
end

function draw()
	cls(13)
	spr(1+t%60//30*2,x,y,14,3,0,0,2,2)
	drawObstacles()
	print("HELLO WORLD!",84,84)
end

init()
function TIC()
	if btn(0) then y=y-1 end
	if btn(1) then y=y+1 end
	if btn(2) then x=x-1 end
	if btn(3) then x=x+1 end
	
	updateObstacles()
	draw()
	t=t+1
	print(obstacles[0][0].y)
end

-- <TILES>
-- 001:efffffffff222222f8888888f8222222f8fffffff8ff0ffff8ff0ffff8ff0fff
-- 002:fffffeee2222ffee88880fee22280feefff80fff0ff80f0f0ff80f0f0ff80f0f
-- 003:efffffffff222222f8888888f8222222f8fffffff8fffffff8ff0ffff8ff0fff
-- 004:fffffeee2222ffee88880fee22280feefff80ffffff80f0f0ff80f0f0ff80f0f
-- 005:4111111414444441411111148000000800000000000000000000000080000008
-- 017:f8fffffff8888888f888f888f8888ffff8888888f2222222ff000fffefffffef
-- 018:fff800ff88880ffef8880fee88880fee88880fee2222ffee000ffeeeffffeeee
-- 019:f8fffffff8888888f888f888f8888ffff8888888f2222222ff000fffefffffef
-- 020:fff800ff88880ffef8880fee88880fee88880fee2222ffee000ffeeeffffeeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:140c1c44243430346d4e4a4e854c30346524d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

