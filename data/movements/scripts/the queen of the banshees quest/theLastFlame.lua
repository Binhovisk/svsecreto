function onStepIn(cid, item, position, fromPosition)
	local player = Player(cid)
	if not player then
		return true
	end

	player:setStorageValue(50021, 1)
	player:teleportTo(Position(32269, 31853, 15))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end