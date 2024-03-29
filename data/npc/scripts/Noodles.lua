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
	local player = Player(cid)
	if msgcontains(msg, "banana skin") then
		if player:getStorageValue(Storage.postman.Mission06) == 7 then
			if player:getItemCount(2219) >= 1 then
				npcHandler:say("<sniff><sniff>", cid)
				npcHandler.topic[cid] = 1
			end
		end
	elseif msgcontains(msg, "dirty fur") then
		if player:getStorageValue(Storage.postman.Mission06) == 8 then
			if player:getItemCount(2220) >= 1 then
				npcHandler:say("<sniff><sniff>", cid)
				npcHandler.topic[cid] = 2
			end
		end
	elseif msgcontains(msg, "mouldy cheese") then
		if player:getStorageValue(Storage.postman.Mission06) == 9 then
			if player:getItemCount(2235) >= 1 then
				npcHandler:say("<sniff><sniff>", cid)
				npcHandler.topic[cid] = 3
			end
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1  then
			npcHandler:say("Woof!", cid)
			player:setStorageValue(Storage.postman.Mission06, 8)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say("Woof!", cid)
			player:setStorageValue(Storage.postman.Mission06, 9)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say("Meeep! Grrrrr! <spits>", cid)
			player:setStorageValue(Storage.postman.Mission06, 10)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
