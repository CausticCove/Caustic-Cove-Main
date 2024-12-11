// Make sure to add a new icon to "/icons/mobs/screen_alert.dmi" and to update the on screen alert to follow that icon path.
// Otherwise, your icons won't appear, and we won't be buffed!

//////////////
//BREW BUFFS//
//////////////
/datum/status_effect/buff/ravoxbuff
	id = "ravoxbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/ravoxbuff
	effectedstats =  list("strength" = 2)
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/ravoxbuff
	name = "Ravox Brew"
	desc = ""
	icon_state = "fentanyl"

/datum/status_effect/buff/abyssorbuff
	id = "abyssorbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/abyssorbuff
	effectedstats =  list("strength" = -2, "speed" = -4)
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/abyssorbuff
	name = "Abyssor Brew"
	desc = ""
	icon_state = "buff"

/datum/status_effect/buff/abyssorbuff/on_apply()
	if(iscarbon(owner))
		ADD_TRAIT(owner, TRAIT_ABYSSORS_BLESSING, TRAIT_GENERIC)
	. = ..()

/datum/status_effect/buff/abyssorbuff/on_remove()
	if(iscarbon(owner))
		REMOVE_TRAIT(owner, TRAIT_ABYSSORS_BLESSING, TRAIT_GENERIC)
	. = ..()

/datum/status_effect/buff/fyritiusbuff
	id = "fyritiusbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fyritiusbuff
	duration = 3 MINUTES

/atom/movable/screen/alert/status_effect/buff/fyritiusbuff
	name = "Fyrite Brew"
	desc = ""
	icon_state = "buff"

/datum/status_effect/buff/fyritiusbuff/on_apply()  //Please if we can add some sort of icon or effect on players do help, I don't know how sprites work haha
	if(iscarbon(owner))
		ADD_TRAIT(owner, TRAIT_FLAMING_TOUCH, TRAIT_GENERIC)
	. = ..()

/datum/status_effect/buff/fyritiusbuff/on_remove()
	if(iscarbon(owner))
		REMOVE_TRAIT(owner, TRAIT_FLAMING_TOUCH, TRAIT_GENERIC)
	. = ..()

////////////////
//POTION BUFFS//
////////////////
/datum/status_effect/buff/fortitudebuff
	id = "fortitudebuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortitude
	effectedstats = list("constitution" = 1, "endurance" = 2)
	duration = 7 MINUTES

/atom/movable/screen/alert/status_effect/buff/fortitude
	name = "Fortitude"
	desc = ""
	icon_state = "fortitude"

/datum/status_effect/buff/swiftnessbuff
	id = "swiftnessbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/swiftness
	effectedstats = list("speed" = 3)
	duration = 7 MINUTES

/atom/movable/screen/alert/status_effect/buff/swiftness
	name = "Swiftness"
	desc = ""
	icon_state = "swiftness"

/datum/status_effect/buff/intellectbuff
	id = "intellectbuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/intellect
	effectedstats = list("perception" = 1, "intelligence" = 2)
	duration = 7 MINUTES

/atom/movable/screen/alert/status_effect/buff/intellect
	name = "Intellect"
	desc = ""
	icon_state = "intellect"

////////////////
//EFFECT BUFFS//
////////////////

/datum/status_effect/buff/virilitybuff
	id = "virilitybuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/virility
	duration = 3000

/atom/movable/screen/alert/status_effect/buff/virility
	name = "Virility"
	desc = ""
	icon_state = "virility"

/datum/status_effect/buff/virilitybuff/on_apply()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.sexcon.set_charge(INFINITY)
	return ..()

/datum/status_effect/buff/virilitybuff/on_remove()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		C.sexcon.set_charge(0)
	return ..()

/datum/status_effect/buff/mfire // Requires a ground riddle of steel and being a follower of malum or baotha.
	id = "mfirebuff"
	alert_type = /atom/movable/screen/alert/status_effect/buff/mfire
	effectedstats = list("endurance" = 4, "fortune" = 4) //In carnage, I bloom, like a flower in the dawn.
	duration = 15 MINUTES // Riddle. HUGE buff duration.

/atom/movable/screen/alert/status_effect/buff/mfire
	name = "Burning Fervor"
	desc = ""
	icon_state = "fire"

/////////////////
//WEATHER BUFFS//
/////////////////

/datum/status_effect/buff/wetness/damp
	id = "wetness1"
	alert_type = /atom/movable/screen/alert/status_effect/buff/wetness/damp
	effectedstats = list("speed" = -1) 
	duration = INFINITY //Removed manually.

/atom/movable/screen/alert/status_effect/buff/wetness/damp
	name = "Damp"
	desc = "I should dry off."
	icon_state = "damp"

/datum/status_effect/buff/wetness/wet
	id = "wetness2"
	alert_type = /atom/movable/screen/alert/status_effect/buff/wetness/wet
	effectedstats = list("endurance" = -1, "speed" = -2) 
	duration = INFINITY //Removed manually.

/atom/movable/screen/alert/status_effect/buff/wetness/wet
	name = "Wet"
	desc = "My clothes stick to me."
	icon_state = "wet"

/datum/status_effect/buff/wetness/drenched
	id = "wetness3"
	alert_type = /atom/movable/screen/alert/status_effect/buff/wetness/drenched
	effectedstats = list("strength" = -1, "endurance" = -1, "speed" = -3) 
	duration = INFINITY //Removed manually.

/atom/movable/screen/alert/status_effect/buff/wetness/drenched
	name = "Drenched"
	desc = "I'm weighed down by all this water!"
	icon_state = "drenched"
