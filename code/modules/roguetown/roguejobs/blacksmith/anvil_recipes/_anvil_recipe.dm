/datum/anvil_recipe
	var/name
	var/list/additional_items = list()
	var/material_quality = 0 // Quality of the bar(s) used. Accumulated per added ingot.
	var/num_of_materials = 1 // Total number of materials used. Quality divided among them.
	var/skill_quality = 0 // Accumulated per hit based on calculations, will decide final result.
	var/appro_skill = /datum/skill/craft/blacksmithing
	var/req_bar
	var/created_item
	var/createditem_num = 1 // How many units to make.
	var/craftdiff = 0
	var/needed_item
	var/needed_item_text
	var/quality_mod = 0
	var/progress
	var/max_progress = 100
	var/i_type
	var/bar_health = 100 // Current material bar health, reduced by failures. At 0 HP it is deleted.
	var/numberofhits = 0 // Increased every time you hit the bar, the more you have to hit the bar the less quality of the product.
	var/numberofbreakthroughs = 0 // How many good hits we got on the metal, advances recipes 50% faster, reduces number of hits total, and restores bar_health
	var/datum/parent

/datum/anvil_recipe/New(datum/P, ...)
	parent = P
	. = ..()

/datum/anvil_recipe/proc/advance(mob/user, breakthrough = FALSE, advance_multiplier = 1)
	if(!isliving(user))
		return
	var/mob/living/L = user
	var/moveup = 1
	var/proab = 0 // Probability to not spoil the bar
	var/skill_level	= user.mind.get_skill_level(appro_skill)
	if(progress >= max_progress)
		to_chat(user, span_info("It's ready."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	if(needed_item)
		to_chat(user, span_info("Now it's time to add a [needed_item_text]."))
		user.visible_message(span_warning("[user] strikes the bar!"))
		return FALSE
	// Calculate probability of a successful strike, based on smith's skill level
	if(!skill_level && !craftdiff)
		proab = 35
	else if(skill_level < craftdiff) //Way out of your league, buddy.
		proab = 10
	else
		proab = min(45 * skill_level, 100)
	// Roll the dice to see if the hit actually causes to accumulate progress
	if(prob(proab))
		moveup += round((skill_level * 6 * L.STASTR/10) * (breakthrough == 1 ? 1.5 : 1))
		moveup -= craftdiff
		progress = min(progress + moveup * advance_multiplier, max_progress)
		numberofhits += 1 * advance_multiplier
	else
		moveup = 0
		numberofhits += 1 * advance_multiplier // Increase regardless of success

	// This step is finished, check if more items are needed and restart the process
	if(progress >= max_progress && additional_items.len)
		needed_item = pick(additional_items)
		var/obj/item/I = new needed_item()
		needed_item_text = I.name
		qdel(I)
		additional_items -= needed_item
		progress = 0

	if(!moveup)
		user.mind.add_sleep_experience(appro_skill, advance_multiplier*L.STAINT/(craftdiff+3), FALSE) //Pity XP
		if(!prob(proab)) // Roll again, this time negatively, for consequences.
			user.visible_message(span_warning("[user] ruins the bar!"))
			skill_quality -= 1 // The more you fuck up, the less quality the end result will be.
			bar_health -= craftdiff // Difficulty of the recipe adds to how critical the failure is
			if(parent)
				var/obj/item/P = parent
				switch(skill_level)
					if(0)
						bar_health -= 25 // 4 strikes and you're out, buddy.
					if(1 to 3)
						bar_health -= floor(20 / skill_level)
					if(4)
						bar_health -= 5
					if(5 to 6)
						if(L.badluck(4)) // Unlucky, not unskilled.
							bar_health -= craftdiff
				if(bar_health <= 0)
					user.visible_message(span_danger("[user] destroys the bar!"))
					qdel(P)
			return FALSE
		else
			user.visible_message(span_warning("[user] fumbles the bar!"))
			return FALSE

	else
		if(user.mind)
			skill_quality += (rand(skill_level*12, skill_level*14) * moveup)*advance_multiplier
			user.mind.add_sleep_experience(appro_skill, advance_multiplier*L.STAINT/(craftdiff+1), FALSE)

		if(breakthrough)
			user.visible_message(span_deadsay("[user] deftly strikes the bar!"))
			if(bar_health < 100)
				bar_health += 20 // Correcting the mistakes, ironing the kinks. Low chance, so rewarding.
		else
			user.visible_message(span_info("[user] strikes the bar!"))
		return TRUE

/datum/anvil_recipe/proc/item_added(mob/user)
	needed_item = null
	user.visible_message(span_info("[user] adds [needed_item_text]"))
	needed_item_text = null

/datum/anvil_recipe/proc/handle_creation(obj/item/I)
	numberofhits = ceil(numberofhits / num_of_materials) // Divide the hits equally among the number of bars required, rounded up.
	if(numberofbreakthroughs) // Hitting the bar the perfect way should be rewarding quality-wise
		numberofhits -= numberofbreakthroughs
	material_quality = floor(material_quality/num_of_materials)-4
	skill_quality = floor((skill_quality/num_of_materials)/1500)+material_quality
	// Finally, the more hits the thing required, the less quality it will be, to prevent low level smiths from dishing good stuff
	skill_quality -= floor(numberofhits * 0.25)
	var/modifier // Multiplier which will determine quality of final product depending on final skill_quality calculation
	switch(skill_quality)
		if(BLACKSMITH_LEVEL_MIN to BLACKSMITH_LEVEL_SPOIL)
			I.name = "ruined [I.name]"
			modifier = 0.3
		if(BLACKSMITH_LEVEL_AWFUL)
			I.name = "awful [I.name]"
			modifier = 0.5
		if(BLACKSMITH_LEVEL_CRUDE)
			I.name = "crude [I.name]"
			modifier = 0.8
		if(BLACKSMITH_LEVEL_ROUGH)
			I.name = "rough [I.name]"
			modifier = 0.9
		if(BLACKSMITH_LEVEL_COMPETENT)
			modifier = 1
		if(BLACKSMITH_LEVEL_FINE)
			I.name = "fine [I.name]"
			modifier = 1.1
		if(BLACKSMITH_LEVEL_FLAWLESS)
			I.name = "flawless [I.name]"
			modifier = 1.2
		if(BLACKSMITH_LEVEL_LEGENDARY to BLACKSMITH_LEVEL_MAX)
			I.name = "masterwork [I.name]"
			modifier = 1.3
			I.polished = 4
			I.AddComponent(/datum/component/metal_glint)

	if(!modifier) // Sanity.
		return

	I.sellprice *= modifier
	if(istype(I, /obj/item/lockpick))
		var/obj/item/lockpick/L = I
		L.picklvl = modifier
