local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, 'yes') then
		local player = Player(cid)
		if player:removeMoney(50) then
			npcHandler:say('And here we go!', cid)
			player:teleportTo(Position(32390, 32195, 8))
			exhibitionPosition:sendMagicEffect(CONST_ME_TELEPORT)
		else
			npcHandler:say('The exhibition is not for free. You have to pay 50 Gold to get in. Next please!', cid)
		end
	else
		npcHandler:say('Then not.', cid)
	end
	npcHandler:releaseFocus(cid)
	npcHandler:resetNpc(cid)
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
