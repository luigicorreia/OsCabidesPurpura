-- title:  game title
-- author: game developer
-- desc:   short description
-- script: lua

t=0
x=96
y=24


hangerAnimation = {261,263,265,267}
iceAnimation = {336, 339}

function TIC()

	if btn(0) then y=y-1 end
	if btn(1) then y=y+1 end
	if btn(2) then x=x-1 end
	if btn(3) then x=x+1 end

	cls(0)
	spr(spriteReturn(hangerAnimation, 4, 5),x,y,0,1,0,0,2,2)
	spr(spriteReturn(iceAnimation, 2, 20),14,14,0,2,0,0,3,3)

	print(hangerSpriteNumber,84,84,12)
	t=t+1
end


function spriteReturn(animation, n, acceleration)

	hangerSpriteNumber = animation[math.ceil((t/acceleration)%n)]

	if(hangerSpriteNumber == nil) then hangerSpriteNumber = 0 end

	return hangerSpriteNumber
end

-- <SPRITES>
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
-- 080:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 081:ddafffffdddddddddddddddddddffffddddaaaddffffddddaaaddddddddddddd
-- 082:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 083:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 084:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 085:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 096:ddaadddddddddddddddddafdddddddddddfffdddddaadddfdddddddaddddafdd
-- 097:ddddddddddffffddddaaadddddddddddddddddddffddddddaddddfffdddddaad
-- 098:ddaadddddddddddddddddafdddddddddddfffdddddaadddfdddddddaddddafdd
-- 099:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 100:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 101:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 112:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 113:ddafffffdddddddddddddddddddffffddddaaaddffffddddaaaddddddddddddd
-- 114:ddddddddddddddddddffffddddaaadddddddddddffffddddaaadddddddfffddd
-- 115:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 116:ddddaddddaffffddaaaaaddddddadddddddaadddffddaaddaddddaafdddddaad
-- 117:ddafffffdddaddddddaaddddddaffffdddaaaaddaaffddddaaadddaaaaaaaaad
-- 033:eee09999ee099999e0999999e0999999e0999999ee0c9999eee0cc99ee060ccc
-- 034:990eeeee9990eeee99990eee99990eee99990eee99c0eeeecc0eeeeec060eeee
-- 035:ee009999e0999999e0999999099999990999999909999999e0c99999ee0cc99c
-- 036:00eeeeee990eeeee990eeeee9990eeee9990eeee9990eeee9c0c0eeec0cc0eee
-- 037:eee09999ee099999e0999999e0999999e0999999ee0c9999eee0cc99ee060ccc
-- 038:990eeeee9990eeee99990eee99990eee99990eee99c0eeeecc0eeeeec060eeee
-- 039:eee00999ee099999ee099999e0999999e0999999e09999990c0c99990cc0cc99
-- 040:900eeeee9990eeee9990eeee99990eee99990eee99990eee99c0eeeecc0eeeee
-- 049:e00660000c0666660c006666e0080000ee088888ee088800ee044400eee000ee
-- 050:06600eee6660c0ee6600c0ee00800eee8880eeee8880eeee4440eeee000eeeee
-- 051:e060cccce00600000cc066660cc00000e0088888eee00008eeeeee04eeeeeee0
-- 052:0600eeee660eeeee600eeeee080eeeee880eeeee880eeeee440eeeee00eeeeee
-- 053:e00660000c0666660c006666e0080000ee088888ee088800ee044400eee000ee
-- 054:06600eee6660c0ee6600c0ee00800eee8880eeee8880eeee4440eeee000eeeee
-- 055:e0060cccee066000ee006666ee080000ee088888ee088800ee04440eeee000ee
-- 056:c060eeee0600eeee60cc0eee00cc0eee8800eeee00eeeeeeeeeeeeeeeeeeeeee
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
-- 000:140c1c4424347d488579405d854c30346524d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

