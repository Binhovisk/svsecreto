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

	if msgcontains(msg, 'spark of the phoenix') then
		if Player(cid):getStorageValue(Storage.KawillBlessing) == 1 then
			npcHandler:say('You already possess my blessing.', cid)
			return true
		end
		
		npcHandler:say('The Spark of the Phoenix is given by me and by the great pyromancer in the nearby fire temple. Do you wish to receive my part of the Spark of the Phoenix?', cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
		local player = Player(cid)
		player:setStorageValue(Storage.KawillBlessing, 1)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		npcHandler:say('So receive the blessing of the life-giving earth, pilgrim.', cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler:say('Ok. If you don\'t want it...', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The gods are treacherous and vain. They want to use us like they did in the past. Only the elements can be trusted, because all they want is for nature to run its set course.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the great geomancer of dwarvenkind.'})
keywordHandler:addKeyword({'geomancer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'We investigate the will of the earth. It is our duty to make sure things to work in their natural way.'})
keywordHandler:addKeyword({'life'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Life is born by earth and fed by earth.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am Kawill Marbleeye, Son of Earth, from the Molten Rock.'})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'There\'s nothing I need, better ask others.'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Nice world in general. It\'s a shame there is so much water ruining the general impression.'})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Time is not of importance.'})
keywordHandler:addKeyword({'monsters'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'May the earth swallow them all!'})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ah, a weapon to be feared by man, beast and god alike, jawoll. He who wields it will be both blessed and cursed at the same time.'})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The day will come when he finally bites the dust.'})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'By using the powers of fire and earth we forced the river that once wound its way through the big old one in other directions, and created our home.'})
keywordHandler:addKeyword({'bezil'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Bezil and Nezil have pawn and equpiment shop with an amazing stock.'})
keywordHandler:addKeyword({'nezil'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Bezil and Nezil have pawn and equpiment shop with an amazing stock.'})
keywordHandler:addKeyword({'duria'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The first knight of dwarvenkind is a fine woman.'})
keywordHandler:addKeyword({'etzel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I fear the sorcerers focus on the destructive forces of fire. They forget about the protection earth could provide.'})
keywordHandler:addKeyword({'jimbin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'He is a jolly fellow and one of the oldest dwarves alive.'})
keywordHandler:addKeyword({'kroox'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'He is a fine smith and his armour may save your neck one day.'})
keywordHandler:addKeyword({'maryza'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'She is a fine cook, jawoll.'})
keywordHandler:addKeyword({'uzgod'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Uzgod is a blacksmith and understands the ways of his element well.'})
keywordHandler:addKeyword({'kruzak'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The emperor has rarely visited the temple district in the last years. He should care more about spirituality then about politics. Jawoll.'})
keywordHandler:addKeyword({'emperor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The emperor has rarely visited the temple district in the last years. He should care more about spirituality then about politics. Jawoll.'})
keywordHandler:addKeyword({'durin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The celestial paladin, the protector of our race. The only divine being we care for and the only one who still cares for dwarfs.'})
keywordHandler:addKeyword({'fire'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Where earth is giving, fire is taking. That is the way of the elements.'})
keywordHandler:addKeyword({'earth'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The lifegiving earth protects us, feeds us and takes us home after death.'})
keywordHandler:addKeyword({'the big old one'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The mountain we live in is called the big old one. It\'s the mountain of mountains, and it isand like a friend and protector to our race.'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome |PLAYERNAME|! May earth protect you!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Earth under your feet, |PLAYERNAME|!')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Earth under your feet, pilgrim. What brings you here?')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
