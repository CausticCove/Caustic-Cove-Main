////////////////
//EFFECT BUFFS//
////////////////


/datum/status_effect/buff/induced_insanity //What is... happening!?
	id = "inducedinsanity"
	alert_type = /atom/movable/screen/alert/status_effect/buff/induced_insanity
	effectedstats = list("strength" = -4, "perception" = -4, "constitution" = -4, "endurance" = -4, "speed" = -4, "fortune" = -4) 
	duration = 3 MINUTES 

/atom/movable/screen/alert/status_effect/buff/induced_insanity
	name = "##^%$*%!!?"
	desc = "WWHAAAT IS HAAAPENNIINGG!?"
	icon_state = "status"

/datum/status_effect/buff/induced_insanity/process()
	. = ..()
	var/mob/living/carbon/human/C = owner
	var/atom/movable/screen/fullscreen/maniac/hallucinations
	//Check if it has the status effect to prevent runtiming NULL
	if(has_status_effect(/datum/status_effect/buff/induced_insanity))
		hallucinations = owner.overlay_fullscreen("maniac", /atom/movable/screen/fullscreen/maniac)
	if(istype(C, /mob/living/carbon/human))
		handle_maniac_visions(C, hallucinations)
		handle_maniac_hallucinations(C)
		handle_maniac_floors(C)
		handle_maniac_walls(C)
	else
