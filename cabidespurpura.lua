-- title:  cAbIdEs
-- author: cabides
-- desc:   lança cruzetas
-- script: lua

DEFAULT_OBSTACLE_Y=-460

t=0
x=110
y=85
inverted=1
createdWeapon = 0
hangerAnimation = {5,7,9,11}
iceAnimation = {336, 339}

function init()
	obstacles={}

	weapon={}

	for i=0, 4 do
		obstacles[i]=createObstacle(DEFAULT_OBSTACLE_Y+i*100)
	end

	gameover=false

	reverse=0

	player={
		x=110,
		y=110
	}


end	


function spriteReturn(animation, n, acceleration, n0)

	hangerSpriteNumber = animation[math.ceil((t/acceleration)%n)]

	if(hangerSpriteNumber == nil) then 
		hangerSpriteNumber = n0
	end
	
		

	return hangerSpriteNumber
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



function playerMovement()
	if btn(0) then player.y=player.y-1*inverted end
	if btn(1) then player.y=player.y+1*inverted end 
	if btn(3) then player.x=player.x+1*inverted end
	if btn(2) then player.x = player.x-1*inverted end
	if(checkBounds()) then 
		if player.x>199 then player.x=199
		else player.x=24
		end
	end
end


function checkBounds()
	if(player.x<24 or player.x>199) then
		return true
	else
		return false
	end
end

function creatWeapons()
	local newWeapon={
		x=player.x,
		y=player.y-5,
		lives=2
	}
	table.insert(weapon,#weapon+1,newWeapon)
end


function shoot()
	if btnp(4) then
		creatWeapons()
	end
end

function updateWeapon()
	for id, eachWeapon in pairs(weapon) do
		eachWeapon.y = eachWeapon.y-1
		drawWeapon()
	end
end

function drawWeapon()
	checkWeaponBoundsAndLives()
	for id,eachWeapon in pairs(weapon) do		
		spr(spriteReturn(hangerAnimation, 4, 5, 5),eachWeapon.x,eachWeapon.y,0,1,0,0,2,2)
	end
end


function checkWeaponBoundsAndLives()
	for id, eachWeapon in pairs(weapon) do
		if(eachWeapon.y < 0 or eachWeapon.lives==0) then
			table.remove(weapon,id)
		end
	end
end


function draw()

	cls(13)
	spr(1,player.x,player.y,14,1,0,0,2,2)
	print("Hello Cabide!",85,0)
	drawObstacles()
	drawWeapon()

end


init()
function TIC()
	playerMovement()
	shoot()
	updateObstacles()
	updateWeapon()
	draw()
	t=t+1
	
end


-- <TILES>
-- 001:efffffffff222222f8888888f8222222f8fffffff8ff0ffff8ff0ffff8ff0fff
-- 002:fffffeee2222ffee88880fee22280feefff80fff0ff80f0f0ff80f0f0ff80f0f
-- 003:efffffffff222222f8888888f8222222f8fffffff8fffffff8ff0ffff8ff0fff
-- 004:fffffeee2222ffee88880fee22280feefff80ffffff80f0f0ff80f0f0ff80f0f
-- 005:0000000000000000000000090000009000000090000000090000000000000032
-- 006:0000000000000000900000000e0000000000000000000000e000000003200000
-- 007:0000000000003300000300300003003000030003000300030003000000030000
-- 008:0000000000000000000000000000000000000000000000003009900020900900
-- 009:0000000000000000000000000222222320000000200000000230000000023000
-- 010:0000000000000000000000003333330000000030000000300000330000330000
-- 011:000000000000000000000000000000000000000000000002000e0003009000e0
-- 012:0022000002002000030020002000200030002000000020000000200000003000
-- 017:f8fffffff8888888f888f888f8888ffff8888888f2222222ff000fffefffffef
-- 018:fff800ff88880ffef8880fee88880fee88880fee2222ffee000ffeeeffffeeee
-- 019:f8fffffff8888888f888f888f8888ffff8888888f2222222ff000fffefffffef
-- 020:fff800ff88880ffef8880fee88880fee88880fee2222ffee000ffeeeffffeeee
-- 021:0000330000330000030000000300000000333333000000000000000000000000
-- 022:0003200000000320000000020000000232222220000000000000000000000000
-- 023:0003000000020000000200000002000300020002000200300002002000002200
-- 024:0e0009003000e000200000000000000000000000000000000000000000000000
-- 025:000002300000000e0000000000000000000000e0000000090000000000000000
-- 026:2300000000000000900000000900000009000000900000000000000000000000
-- 027:0090090200099003000000000000000000000000000000000000000000000000
-- 028:0000300000003000300030003000300003003000030030000033000000000000
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
-- 000:140c1c4424347d488579405d854c30346524d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

