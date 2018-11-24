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
left=0
right=0
up=0
down=0

hangerAnimation = {261,263,265,267}
hangern0 = 261
iceAnimation = {336, 339}
characterAnimationUp = {289, 291, 293, 295}
characterSidewaysLeft = {422,424,426,428}
characterSidewaysRight = {454,456,458,460}
characterAnimationDown = {390,392,394,396}
wardrobeAnimation = {384, 387}
drawerAnimation = {432, 435}
spammingHanger = 30
hangerShot = false
canShoot = true




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
	if btn(0) then
		up=1
		down=0
		right=0
		left=0 
		player.y=player.y-1*inverted 
	end
	if btn(1) then
		up=0
		down=1
		right=0
		left=0  
		player.y=player.y+1*inverted 
	end 
	if btn(3) then
		up=0
		down=0
		right=1
		left=0 
		player.x=player.x+1*inverted
	end
	if btn(2) then
		up=0
		down=0
		right=0
		left=1
		player.x = player.x-1*inverted
	end
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
	if (btnp(4) and canShoot) then
		creatWeapons()
		hangerShot = true
		canShoot = false
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
		spr(spriteReturn(hangerAnimation, 4, 5, hangern0),eachWeapon.x,eachWeapon.y,0,1,0,0,2,2)
	end
end


function checkWeaponBoundsAndLives()
	for id, eachWeapon in pairs(weapon) do
		if(eachWeapon.y < 0 or eachWeapon.lives==0) then
			table.remove(weapon,id)
		end
	end
end

function drawPlayer()
	if(left==1) then
		spr(spriteReturn(characterSidewaysLeft,4,30,422),player.x,player.y,14,1,0,0,2,2)
	elseif(up==1) then
		spr(spriteReturn(characterAnimationUp, 4, 30, 295),player.x,player.y,14,1,0,0,2,2)
	elseif(down==1) then
		spr(spriteReturn(characterAnimationDown, 4, 30, 390),player.x,player.y,14,1,0,0,2,2)
	elseif(right==1) then
		spr(spriteReturn(characterSidewaysRight, 4, 30, 454),player.x,player.y,14,1,0,0,2,2)
	else
		spr(spriteReturn(characterSidewaysRight, 4, 30, 454),player.x,player.y,14,1,0,0,2,2)
	end
end

function draw()

	cls(13)
	drawPlayer()
	print("Hello Cabide!",85,0)
	drawObstacles()
	drawWeapon()
	print(spammingHanger, 85, 23)
	
	
end


init()
function TIC()
	playerMovement()
	shoot()
	updateObstacles()
	updateWeapon()
	draw()
	t=t+1
	if(hangerShot) then spammingHanger = spammingHanger - 1 end 
	if(spammingHanger == 0) then 
		spammingHanger = 30 
		canShoot = true
		hangerShot = false
	end 
end


-- <TILES>
-- 000:4444444454444444555555554445554454444454544444545444445454444454
-- 001:4444544444445444555555554555444544445444444454444444544444445444
-- 016:5444445454444454555555554445444444454444444544444445444444454444
-- 017:4444544444445444555555554544444545444444454444444544444445444444
-- 032:4444444454444454555555554445444444444444444444444444444444444444
-- 033:4444444444445444555555554544444544444444444444444444444444444444
-- 048:4444444444444444444444444444444444444444444444444444444444444444
-- 049:4444444444444444444444444444444444444444444444444444444444444444
-- 004:3333333333333333333333333333333333333333333333333333333333333333
-- 005:3333333333333333333333333333333333333333333333333333333333333333
-- 020:3333333333333333333333333333333333333333333333333333333333333333
-- 021:3333333333333333333333333333333333333333333333333333333333333333
-- </TILES>

-- <SPRITES>
-- 000:66666eee6eee6eee6e6e6eee6eee6eee66666eeeeeeeeeeeeeeeeeeeeeeeeeee
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
-- 033:eee09999ee099999e0999999e0999999e0999999ee0c9999eee0cc99ee060ccc
-- 034:990eeeee9990eeee99990eee99990eee99990eee99c0eeeecc0eeeeec060eeee
-- 035:ee009999e0999999e0999999099999990999999909999999e0c99999ee0cc99c
-- 036:00eeeeee990eeeee990eeeee9990eeee9990eeee9990eeee9c0c0eeec0cc0eee
-- 037:eee09999ee099999e0999999e0999999e0999999ee0c9999eee0cc99ee060ccc
-- 038:990eeeee9990eeee99990eee99990eee99990eee99c0eeeecc0eeeeec060eeee
-- 039:eee00999ee099999ee099999e0999999e0999999e09999990c0c99990cc0cc99
-- 040:900eeeee9990eeee9990eeee99990eee99990eee99990eee99c0eeeecc0eeeee
-- 041:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee448eeeee888
-- 042:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8888884488888888
-- 043:eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00
-- 044:00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee
-- 045:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
-- 046:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
-- 049:e00660000c0666660c006666e0080000ee088888ee088800ee044400eee000ee
-- 050:06600eee6660c0ee6600c0ee00800eee8880eeee8880eeee4440eeee000eeeee
-- 051:e060cccce00600000cc066660cc00000e0088888eee00008eeeeee04eeeeeee0
-- 052:0600eeee660eeeee600eeeee080eeeee880eeeee880eeeee440eeeee00eeeeee
-- 053:e00660000c0666660c006666e0080000ee088888ee088800ee044400eee000ee
-- 054:06600eee6660c0ee6600c0ee00800eee8880eeee8880eeee4440eeee000eeeee
-- 055:e0060cccee066000ee006666ee080000ee088888ee088800ee04440eeee000ee
-- 056:c060eeee0600eeee60cc0eee00cc0eee8800eeee00eeeeeeeeeeeeeeeeeeeeee
-- 057:eeeee888eeeee888eeeee888eeeee888eeeee888eeeee888eeeee844eeeee444
-- 058:88e888888eee88888eee88888eee88888eee88888eee88888eee84484eee4444
-- 059:eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00
-- 060:00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee
-- 061:eeeeeeeeeeeeeeeeeeeeaaeeeee9999eeeaaaaaae99999990000000099999999
-- 062:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9eeeeeee00eeeeee99eeeeee
-- 073:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000
-- 074:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000
-- 075:eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee000000000000000000
-- 076:00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee0000000000000000
-- 077:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000
-- 078:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000
-- 080:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 081:ddafffffdddddddddddddddddddffffddddaaaddffffddddaaaddddddddddddd
-- 082:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 083:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 084:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 085:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 089:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee6660
-- 090:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0666ee
-- 091:eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00
-- 096:ddaadddddddddddddddddafdddddddddddfffdddddaadddfdddddddaddddafdd
-- 097:ddddddddddffffddddaaadddddddddddddddddddffddddddaddddfffdddddaad
-- 098:ddaadddddddddddddddddafdddddddddddfffdddddaadddfdddddddaddddafdd
-- 099:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 100:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 101:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 105:eee66660ee666660ee666660ee66e660eeeee660eeeee660eeeee660eeeee660
-- 106:ee06666e660666666606666666066e6666066eee66066eee66066eee66066eee
-- 107:eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00
-- 112:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 113:ddafffffdddddddddddddddddddffffddddaaaddffffddddaaaddddddddddddd
-- 114:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 115:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 116:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 117:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 128:0000000000000000004444440044444400444444004444440044444400444444
-- 129:0000000000000000444004444440044444400444444004444440044444400444
-- 130:0000000000000000444445004444450044444500444444004444450044444500
-- 131:0000000000000000005444440054444400544444004444440054444400544444
-- 132:0000000000000000444004444440044444400444444004444440044444400444
-- 133:0000000000000000444444004444440044444400444444004444440044444400
-- 144:0044444400444444004444050044440500444405004444440044444400444444
-- 145:4440044444400444444004444440044444400444444004444440044444400444
-- 146:4444440044444400054445000544450005444500444445004444450044444400
-- 147:0044444400444444005444500054445000544450005444440054444400444444
-- 148:4440044444400444444004444440044444400444444004444440044444400444
-- 149:4444440044444400504444005044440050444400444444004444440044444400
-- 160:004444440044444400444444004444440044444400444000000000000000000e
-- 161:44400444444004444440044444400444444004440000000000000000eeeeeeee
-- 162:44444400444445004444450044444500400000000000000000eeeeeeeeeeeeee
-- 163:004444440054444400544444005444440000000400000000eeeeee00eeeeeeee
-- 164:44400444444004444440044444400444444004440000000000000000eeeeeeee
-- 165:44444400444444004444440044444400444444000004440000000000e0000000
-- 176:0000000000000000004444440044444400444444004444440044444400444444
-- 177:0000000000000000444444444444444444444444450004444444444444444444
-- 178:0000000000000000444445004444450044444500444444004444450044444500
-- 179:0000000000000000005444440054444400544444004444440054444400544444
-- 180:0000000000000000444444444444444444444444444000544444444444444444
-- 181:0000000000000000444444004444440044444400444444004444440044444400
-- 192:005555550044444400444444004444440044444400444400000000000000000e
-- 193:55555555444444444444444445000444444444400000000000000000eeeeeeee
-- 194:555555004444450044444500444445000000000000000000eeeeee00eeeeee00
-- 195:00555555005444440054444400544444000000000000000000eeeeee00eeeeee
-- 196:55555555444444444444444444400054044444440000000000000000eeeeeeee
-- 197:55555500444444004444440044444400444444000044440000000000e0000000
-- 121:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000
-- 122:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000
-- 123:eeeeee00eeeeee00eeeeee00eeeeee00eeeeee00eeeeee000000000000000000
-- 134:eeee0999eee09999ee09c999ee0cccc9ee0ccccceee0cc0ceeee0c0ceee060cc
-- 135:9990eeee99990eee999990ee9999c0eeccccc0eec0cc0eeec0c0eeeecc060eee
-- 136:eeee0999eee09999eee09999ee09c999ee0cccccee0ccccceee0cc0ceee00c0c
-- 137:9990eeee99990eee99990eee999990ee9999c0eeccccc0eec0cc00eec0c0cc0e
-- 138:eeee0999eee09999ee09c999ee0cccc9ee0ccccceee0cc0ceeee0c0ceee060cc
-- 139:9990eeee99990eee999990ee9999c0eeccccc0eec0cc0eeec0c0eeeecc060eee
-- 140:eeee0999eee09999eee09999ee099999ee0c9999ee0cccccee00cc0ce0cc0c0c
-- 141:9990eeee99990eee99990eee999c90eeccccc0eeccccc0eec0cc0eeec0c00eee
-- 150:ee0c6600e0cc0666e0cc0666ee008000eee08888eee08880eee04440eeee000e
-- 151:0066c0ee6660cc0e6660cc0e000800ee88880eee08880eee04440eeee000eeee
-- 152:ee0c00ccee00cc00eee0cc06eee00000eee08888eeee0000eeeeeeeeeeeeeeee
-- 153:cc060c0e006600ee66000eee00880eee08880eee08880eee04440eeee000eeee
-- 154:ee0c6600e0cc0666e0cc0666ee008000eee08888eee08880eee04440eeee000e
-- 155:0066c0ee6660cc0e6660cc0e000800ee88880eee08880eee04440eeee000eeee
-- 156:e0c060ccee006600eee00066eee08800eee08880eee08880eee04440eeee000e
-- 157:cc00c0ee00cc00ee60cc0eee00000eee88880eee0000eeeeeeeeeeeeeeeeeeee
-- 166:eeee0099eee09999ee099999e09c9999ee0cc999ee0c0c99ee0c0ccceee0cccc
-- 167:900eeeee9990eeee9990eeee99990eee99990eeec9990eeecc990eeeccc0eeee
-- 168:eeeeee00eeee0099eee09999eee09999ee09c999eee0cc99eee0c0c9eee0c0cc
-- 169:00eeeeee9900eeee99990eee9999900e9999990e9999990e99c9990ecccc990e
-- 170:eeee0099eee09999ee099999e09c9999ee0cc999ee0c0c99ee0c0ccceee0cccc
-- 171:900eeeee9990eeee9990eeee99990eee99990eeec9990eeecc990eeeccc0eeee
-- 172:eeeeee00eeee0099eee09999eee09999ee09c999eee0cc99eee0c0c9eee0c0cc
-- 173:00eeeeee9900eeee99990eee999990ee999990ee999990ee99c990eecccc90ee
-- 182:eeee0ccceeeee000eeee0600eeee00cceeeee0cceeee0800eeee0444eeeee000
-- 183:cc0eeeee00eeeeee660eeeee060eeeee060eeeee80eeeeee40eeeeee0eeeeeee
-- 184:eeee0ccceeee00cceee0cc00eee0c066eee00666ee044080eee04400eeee00ee
-- 185:ccccc0eeccc00eee000cc0ee660cc0ee66600eee88040eee00440eeeee00eeee
-- 186:eeee0ccceeeee000eeee0600eeee00cceeeee0cceeee0800eeee0444eeeee000
-- 187:cc0eeeee00eeeeee660eeeee060eeeee060eeeee80eeeeee40eeeeee0eeeeeee
-- 188:eeee0ccceee000ccee0cc000ee0cc066eee00666ee044080eee04400eeee00ee
-- 189:cccc00eeccc00eee0000c0ee6660c0ee66600eee88040eee00440eeeee00eeee
-- 198:eeeee009eeee0999eeee0999eee09999eee09999eee0999ceee099cceeee0ccc
-- 199:9900eeee99990eee999990ee9999c90e999cc0ee99c0c0eeccc0c0eecccc0eee
-- 200:eeeeee00eeee0099eee09999ee099999ee099999ee099999ee099c99ee09cccc
-- 201:00eeeeee9900eeee99990eee99990eee999c90ee99cc0eee9c0c0eeecc0c0eee
-- 202:eeeee009eeee0999eeee0999eee09999eee09999eee0999ceee099cceeee0ccc
-- 203:9900eeee99990eee999990ee9999c90e999cc0ee99c0c0eeccc0c0eecccc0eee
-- 204:eeeeee00eeee0099eee09999e0099999e0999999e0999999e0999c99e099cccc
-- 205:00eeeeee9900eeee99990eee99990eee999c90ee99cc0eee9c0c0eeecc0c0eee
-- 214:eeeee0cceeeeee00eeeee066eeeee060eeeee060eeeeee08eeeeee04eeeeeee0
-- 215:ccc0eeee000eeeee0060eeeecc00eeeecc0eeeee0080eeee4440eeee000eeeee
-- 216:ee00cccceee00cccee0c0000ee0c0666eee00666eee04088eee04400eeee00ee
-- 217:ccc0eeeecc000eee000cc0ee660cc0ee66600eee080440ee00440eeeee00eeee
-- 218:eeeee0cceeeeee00eeeee066eeeee060eeeee060eeeeee08eeeeee04eeeeeee0
-- 219:ccc0eeee000eeeee0060eeeecc00eeeecc0eeeee0080eeee4440eeee000eeeee
-- 220:ee0ccccceee00cccee0cc000ee0cc066eee00666eee04088eee04400eeee00ee
-- 221:ccc0eeeecc00eeee00cc0eee660c0eee66600eee080440ee00440eeeee00eeee
-- </SPRITES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:140c1c4424347d488579405d854c30ae7134d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

