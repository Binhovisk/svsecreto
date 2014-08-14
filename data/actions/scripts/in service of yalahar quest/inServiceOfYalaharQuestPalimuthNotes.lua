function onUse(cid, item, fromPosition, itemEx, toPosition)
	if(item.uid == 3076) then
		local player = Player(cid)
		if(player:getStorageValue(649) < 1) then
			player:setStorageValue(649, 1)
        		local bag = doPlayerAddItem(cid,1987,1)
        		local item1a = doAddContainerItem(bag,1954,1)
        		local item2a = doAddContainerItem(bag,1954,1)
        		doSetItemText(item2a, "History of the Augur, Part II\nThey brought more and more people to Yalahar. Not all of them became Augur, a good part of them lived in Yalahar as ordinary citizens. At some point, the city had reached a much larger population than under the rule of the true Yalahari, and it became difficult to provide food and shelter for everyone. Time and overuse took it's toll on the city. Over the years, more and more parts of the city were lost due to ignorance, lack of resources, or catastrophes. The new Yalahari were unable to restore broken machines and devices, and their efforts to retake certain parts of the city with the help of the Augur caused only more disaster. So the new Yalahari decided to stay in the city's centre, letting the Augur care for the rest of the city as well as they could. Still, their image as Yalahari allowed them to claim supremacy and to rule over the whole city.\nThis all did not matter too much to our ancestors. The new Yalahari were neither cruel nor overly abusive, and they still wielded the powerful weapons and armors of the true Yalahari. So they stuck to the status quo and continued to work for the Yalahari despite everything they had found out. This worked quite well although the city was still declining and great parts of it had been lost to chaos and anarchy.\nLately, though, things started to change. It is not a dramatic change but it can be recognised gradually at many places. Some of the known routines in the orders of the Yalahari have altered. There are more and more orders who have a dubious purpose. The most frightening thing is that some orders obviously hint at a person with Yalahari knowledge that had been considered as lost for centuries. The overwhelming majority of the new Yalahari still clings to their ignorant and self-centred ways, but perhaps one of them or a small group has discovered some hidden secrets of their vanished masters. It is also possible that something completely different is happening, we simply don't know. But these new orders that seem to aim at restoring order in the city have some bitter taste. They are somewhat oppressive and destructive, not in an obvious way, though. Taken together, they paint a dark picture of Yalahar's future. A future of oppression, betrayal, and a much stricter rule by the Yalahari.")
        		doSetItemText(item1a,"History of the Augur, Part I\nWe, the families of the Augur, have been living here for many generations. In the course of time, we acquired certain insights in the ways of our masters, the Yalahari. Many years ago, things used to be very different in this city. Once it was a marvel to behold, but then it started to decay slowly and steadily. This process of deterioration begun in the far past, long before our ancestors came here. At the time they were brought here by the Yalahari as helpers and workers, the city already showed signs of decline. Despite their claim of having great power, the Yalahari could do little to stop the catastrophes that should occur. Neither did they do anything to restore the damaged parts of the city. Still, it took many centuries until the city had reached the pitiful state that you can witness today.\nSome decades ago, a group of Augur suspected that we all were lied to by our masters. They started to look for clues that proved their assumptions, and secretly gathered parts of the puzzle one by one. For all we know, there had been indeed a powerful race called the Yalahari that built this city to distance itself from the wars of some capricious gods. So far the tales that our masters had told us, have been true. These Yalahari were served by a group of Augur such as us. They were their helpers and workers, and the Yalahari shared some of their luxuries and achievements with them. The Yalahari concentrated on research and art, and left the more manual work to their servants, who often only knew what they had to do without understanding their tasks.\nAt one far-away point in history, the Yalahari seemingly vanished. Certain clues that our ancestors gathered, hint that they locked themselves in the city's centre and cut off all contact to their helpers. When the Augur sometime later dared to enter the inner city, the Yalahari were all gone - vanished without a trace. After getting over the initial shock, the Augur assumed the role of the Yalahari themselves. For a while they tried to get familiar with some of the secrets of their lost masters, but they were only able to understand the most basic concepts of the Yalahari's knowledge. They stuck to their usual tasks to keep the city running. Still, they were too few to keep the enormous city, of which they understood so little, in shape.\nSo they decided to recruit Augur on their own. This way most of our forefathers came to Yalahar.\nIn the meanwhile, the former Augur retreated into the inner city.")
			player:sendTextMessage(MESSAGE_INFO_DESCR, "You've found some notes.")
		else
			player:sendTextMessage(MESSAGE_INFO_DESCR, "The chest is empty.")
		end
	end
	return true
end