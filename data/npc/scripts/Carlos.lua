local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
local voices = {
	"Hmm, we should do something about your outfit.",
	"Ah, another adventurer. Let's talk a little.", "Psst! Come over here for a little trade.",
	"Hello, hello! Don't be shy, I don't bite.",
	"By the way, if you want to look at old hints again, find the 'Help' button near your inventory and select 'Tutorial Hints'."
}

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 10)
		if math.random(100) < 20 then
			Npc():say(voices[math.random(#voices)], TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function getTable()
	local itemsList = {
		{name="meat", id=2666, sell=2},
		{name="ham", id=2671, sell=2},
	}
	return itemsList
end

local storeTalkCid = {}

local function greetCallback(cid)
	local player = Player(cid)
	if player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Be greeted, ".. player:getName() .."! As a tailor and merchant I have to say - we need to do something about your {outfit}, shall we?")
		player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 1)
		player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 1)
		storeTalkCid[cid] = 1
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Hey, I thought you were going to run away, but luckily you came back. I'll show you how to change your {outfit}, okay?")
		storeTalkCid[cid] = 1
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 2 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back! You know, after providing my little outfit service, I like to ask a little favour of you. Can you {help} me?")
		storeTalkCid[cid] = 2
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 3 then
		npcHandler:setMessage(MESSAGE_GREET, "Oh hey ".. player:getName() ..", you didn't answer my question yet - could you help me get some {food}? I'll even give you some gold for it.")
		storeTalkCid[cid] = 3
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 4 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back ".. player:getName() ..", I hope you changed your mind and will bring me some {meat}? I'll even give you some gold for it.")
		storeTalkCid[cid] = 4
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 5 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, ".. player:getName() .."! Did you have a successful hunt and carry a piece of {meat} or ham with you?")
		storeTalkCid[cid] = 5
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 6 then
		if player:getItemCount(2666) >= 1 or player:getItemCount(2671) >= 1 then
			npcHandler:setMessage(MESSAGE_GREET, "Welcome back, Isleth Eagonst! Do you still have that piece of meat or ham? If so, please ask me for a {trade} and I'll give you some gold for it.")
			storeTalkCid[cid] = 6
		else
			npcHandler:setMessage(MESSAGE_GREET, "Welcome back, ".. player:getName() .."! Where did you put that delicious piece of food? Did you eat it yourself? Well, if you find another one, please come back.")
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		end
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 7 then
		npcHandler:setMessage(MESSAGE_GREET, "Hey there, ".. player:getName() .."! Well, that's how trading with NPCs like me works. I think you are ready now to cross the bridge to Rookgaard! Take care!")
		player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 7)
		player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 8)
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	elseif player:getStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage) == 8 then
		npcHandler:setMessage(MESSAGE_GREET, "Hello again, ".. player:getName() .."! What are you still doing here? You should head over the bridge to Rookgaard village now!")
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	end
	return true
end

local function releasePlayer(cid)
	if not Player(cid) then
		return
	end

	npcHandler:releaseFocus(cid)
	npcHandler:resetNpc(cid)
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	if isInArray({"yes", "help", "ok"}, msg) then
		if storeTalkCid[cid] == 1 then
			npcHandler:say("Very well. Just choose an outfit and a colour combination that suits you. You can open this dialogue anytime by right-clicking on yourself and selecting 'Set Outfit'. Just try it and then talk to me again!", cid)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 2)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 2)
			player:sendTutorial(12)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		elseif storeTalkCid[cid] == 2 then
			npcHandler:say("You see, I'm quite hungry from standing here all day. Could you get me some {food}?", cid)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 3)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 3)
			storeTalkCid[cid] = 3
		elseif storeTalkCid[cid] == 3 then
			npcHandler:say("Thank you! I would do it myself, but I don't have a weapon. Just kill a few rabbits or deer, loot food from them and bring me one piece of {meat} or ham, will you?", cid)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 4)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 4)
			storeTalkCid[cid] = 4
		elseif storeTalkCid[cid] == 4 then
			npcHandler:say("Splendid. I'll be awaiting your return eagerly. Don't forget that you can click on the 'Chase Opponent' button to run after those fast creatures. Good {bye} for now!", cid)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 5)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 5)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		elseif storeTalkCid[cid] == 5 then
			if player:getItemCount(2666) >= 1 or player:getItemCount(2671) >= 1 then
				npcHandler:say("What's that delicious smell? That must be a piece of meat! Please hurry, simply ask me for a {trade} and I'll give you two gold pieces for it!", cid)
				player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 6)
				player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 6)
				storeTalkCid[cid] = 6
			else
				npcHandler:say("Hmm. No, I don't think you have something with you that I'd like to eat. Please come back once you looted a piece of meat or a piece of ham from a rabbit or deer.", cid)
				npcHandler:releaseFocus(cid)
				npcHandler:resetNpc(cid)
			end
		elseif storeTalkCid[cid] == 7 then
			npcHandler:say("Well, that's how trading with NPCs like me works. I think you are ready now to cross the bridge to Rookgaard, just follow the path to the northwest. Good luck, ".. player:getName() .."! ...", cid)
			npcHandler:say("And by the way: if you thought all of this was boring and you'd rather skip the tutorial with your next character, just say 'skip tutorial' to Santiago. ...", cid)
			npcHandler:say("Then you'll miss out on those nice items and experience though. Hehehe! It's your choice. Well, take care for now!", cid)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 7)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 8)
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		end
	elseif msgcontains(msg, "outfit") then
		if storeTalkCid[cid] == 1 then
			npcHandler:say({"Well, that's how trading with NPCs like me works. I think you are ready now to cross the bridge to Rookgaard, just follow the path to the northwest. Good luck, ".. player:getName() .."! ...",
					"And by the way: if you thought all of this was boring and you'd rather skip the tutorial with your next character, just say 'skip tutorial' to Santiago. ...",
					"Then you'll miss out on those nice items and experience though. Hehehe! It's your choice. Well, take care for now!"
			}, cid, 0, 1, 1)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 7)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 8)
			addEvent(releasePlayer, 1000, cid)
		end
	elseif msgcontains(msg, "trade") then
		if storeTalkCid[cid] == 6 then
			npcHandler:say("Very nice! Food for me! Sell it to me, fast! Once you sold your food to me, just say {ready} to let me know you are done.", cid)
			player:sendTutorial(13)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 7)
			storeTalkCid[cid] = 7
			local items = setNewTradeTable(getTable())
			local function onSell(cid, item, subType, amount, ignoreEquipped)
				if items[item].sellPrice then
					return
					player:removeItem(items[item].itemId, amount, -1, ignoreEquipped) and
					player:addMoney(items[item].sellPrice * amount) and

					player:sendTextMessage(MESSAGE_INFO_DESCR, 'You sold '..amount..'x '..items[item].realName..' for '..items[item].sellPrice * amount..' gold coins.')
				end
				return true
			end
			openShopWindow(cid, getTable(), onBuy, onSell)
		end
	elseif msgcontains(msg, "ready") then
		if storeTalkCid[cid] == 7 then
			npcHandler:say({"Well, that's how trading with NPCs like me works. I think you are ready now to cross the bridge to Rookgaard, just follow the path to the northwest. Good luck, ".. player:getName() .."! ...",
					"And by the way: if you thought all of this was boring and you'd rather skip the tutorial with your next character, just say 'skip tutorial' to Santiago. ...",
					"Then you'll miss out on those nice items and experience though. Hehehe! It's your choice. Well, take care for now!"
			}, cid, 0, 1, 1)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosQuestLog, 7)
			player:setStorageValue(Storage.RookgaardTutorialIsland.CarlosNpcGreetStorage, 8)
			addEvent(releasePlayer, 5000, cid)
		end
	end
	return true
end

local function onReleaseFocus(cid)
	storeTalkCid[cid] = nil
end

npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye |PLAYERNAME|!.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye traveller and enjoy your stay on Rookgaard.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
