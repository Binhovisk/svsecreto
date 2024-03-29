local config = {
    [39511] = {
        fromPosition = Position(32739, 32392, 14), 
        toPosition = Position(32739, 32391, 14)
    },
    [39512] = {
        teleportPlayer = true, 
        fromPosition = Position(32739, 32391, 14), 
        toPosition = Position(32739, 32392, 14)
    }
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local useItem = config[item.actionid]
    if not useItem then
        return true
    end

    if useItem.teleportPlayer then
        local player = Player(cid)
        player:teleportTo(Position(32712, 32392, 13))
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:say('Beauty has to be rewarded! Muahahaha!', TALKTYPE_MONSTER_SAY)
    end

    local tapestry = Tile(useItem.fromPosition):getItemById(6434)
    if tapestry then
        tapestry:moveTo(useItem.toPosition)
    end
    return true
end
