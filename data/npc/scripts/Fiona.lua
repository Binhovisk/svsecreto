local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 5)
		if math.random(100) < 25 then
			Npc():say("The Edron academy is always in need of magical ingredients!", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

keywordHandler:addKeyword({'magical ingredients'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Oof, there are too many to list. Magical ingredients can sometimes be found when you defeat a monster, for example bat wings. I buy many of these things if you don't want to use them for quests, just ask me for a {trade}."})

npcHandler:setMessage(MESSAGE_GREET, "Good day, |PLAYERNAME|. I hope you bring a lot of {magical ingredients} with you.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and please come back soon.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye and please come back soon.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Sure, take a look. Apart from those, I also buy some of the possessions from famous demonlords and bosses. Ask me about it if you found anything interesting.")
npcHandler:addModule(FocusModule:new())
