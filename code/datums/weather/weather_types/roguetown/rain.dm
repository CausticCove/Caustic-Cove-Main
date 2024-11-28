
/datum/weather/rain
	name = "rain"
	desc = ""

	telegraph_duration = 10 SECONDS
	telegraph_message = span_warning("The sky begins to weep.")
	telegraph_sound = 'sound/blank.ogg'

	weather_message = ""
	weather_overlay = "rain1"
	weather_duration_lower = 5 MINUTES
	weather_duration_upper = 12 MINUTES
	weather_sound = 'sound/blank.ogg'
	weather_alpha = 255

	probability = 3

	end_duration = 5 SECONDS
	end_message = ""
	end_sound = 'sound/blank.ogg'

	area_type = /area/rogue/outdoors
	protected_areas = list(/area/rogue/indoors,/area/rogue/under)
	impacted_z_levels = list()
	var/lastlightning = 0

	particles = list(/obj/emitters/weather/rain)

/datum/weather/rain/New(z_levels)
	impacted_z_levels = GLOB.sky_z.Copy()
	. = ..()

/datum/weather/rain/weather_act(atom/A)
	if(isliving(A))
		var/mob/living/M = A
		M.adjust_fire_stacks(-100)
		M.SoakMob(FULL_BODY)
		return TRUE
	var/datum/reagent/water/W = new()
	if(isobj(A))
		var/obj/O = A
		W.reaction_obj(O, 100)
	if(isopenturf(A))
		var/turf/open/T = A
		for(var/obj/effect/decal/cleanable/blood/target in T)
			qdel(target)
		//W.reaction_turf(T, 300) //Don't muddy up the whole forest..
	qdel(W)
	return ..()

/datum/weather/rain/get_used_state()
	switch(stage)
		if(STARTUP_STAGE)
			return "bla1"
//			return telegraph_overlay
		if(MAIN_STAGE)
			return pick("rain1", "rain2", "rain3", "rain4")
		if(WIND_DOWN_STAGE)
			return "bla2"
			// return end_overlay
	return "bla3"

/datum/weather/rain/starteffected()
	..() //the parent does all living mobs already
//	for(var/mob/living/L in GLOB.mob_living_list)
//		if(can_weather_act(L))
//			SSweather.uniqueadd(L)
//			START_PROCESSING(SSweather, L)
//	for(var/obj/O in GLOB.rain_update)
//		if(can_weather_act(O))
//			SSweather.uniqueadd(O)
//			START_PROCESSING(SSweather, O)
//	for(var/obj/O in GLOB.fires_list)
//		if(can_weather_act(O))
//			START_PROCESSING(SSweather,O)

/datum/weather/rain/initialprocess()
	..()
//	for(var/turf/T in GLOB.dirt_list)
//		if(can_weather_act(T))
///			SSweather.uniqueadd(T, TRUE)
//			START_PROCESSING(SSweather, T)

/mob/living/carbon/proc/reset_lightning()
	if(lightning_flashing)
		lightning_flashing = FALSE
		update_sight()

/datum/weather/rain/process()
	. = ..()
#ifndef TESTSERVER
	if(GLOB.forecast != "rain")
		wind_down()
		return
#endif

/datum/weather/rain/unprotected_weather_act(mob/living/carbon/M)
	//Wetness mechanics
	var/threshold = M.get_covered_limbs()
	if(!M.is_wet)
		M.is_drying = FALSE
		M.is_wet = TRUE
		spawn(rand(60, 80) * threshold)
			if(!istype(get_area(M), area_type)) //If in doors then don't wet again
				return
			switch(threshold)
				if(0) //No coverage
					M.apply_status_effect(/datum/status_effect/buff/wetness/drenched)
					M.is_drying = FALSE
				if(2)
					M.apply_status_effect(/datum/status_effect/buff/wetness/wet)
					M.is_drying = FALSE
				if(4)
					M.apply_status_effect(/datum/status_effect/buff/wetness/damp)
					M.is_drying = FALSE
				if(6)
					M.is_wet = FALSE 
					M.is_drying = FALSE
					
	if(world.time < lastlightning + 66 SECONDS)
		return
	lastlightning = world.time
	for(M in GLOB.player_list)
		M.playsound_local(M, pick('sound/ambience/noises/thunout (1).ogg','sound/ambience/noises/thunout (2).ogg','sound/ambience/noises/thunout (3).ogg','sound/ambience/noises/thunout (4).ogg'), 100, FALSE)
		M.lightning_flashing = TRUE
		M.update_sight()
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living/carbon, reset_lightning)), 1)

/datum/weather/rain/protected_weather_act(mob/living/carbon/M)
	//Weather drying
	var/threshold = M.get_covered_limbs()
	if(M.is_wet && !M.is_drying)
		M.is_drying = TRUE //Anti loop spam and drying check
		spawn(1800 / (threshold / 10)) //Stay protected for 3 minutes. Weather Threshold makes this faster.
			if(!istype(get_area(M), area_type) && M.is_drying)
			//Remove them ALL just in case.
				M.remove_status_effect(/datum/status_effect/buff/wetness/damp)
				M.remove_status_effect(/datum/status_effect/buff/wetness/wet)
				M.remove_status_effect(/datum/status_effect/buff/wetness/drenched)
				to_chat(M, "I feel dry again.")
				M.is_wet = FALSE
				M.is_drying = FALSE
			else
				M.is_drying = FALSE

	if(world.time < lastlightning + 66 SECONDS)
		return
	lastlightning = world.time
	for(M in GLOB.player_list)
		M.playsound_local(M, pick('sound/ambience/noises/thunin (1).ogg','sound/ambience/noises/thunin (2).ogg','sound/ambience/noises/thunin (3).ogg','sound/ambience/noises/thunin (4).ogg'), 100, FALSE)

/datum/weather/rain/start()
	. = ..()
	for(var/M in GLOB.player_list)
		if(isliving(M))
			var/mob/living/L = M
			if(L.client)
				SSdroning.play_rain(get_area(L), L.client)

/datum/weather/rain/end()
	. = ..()
	for(var/M in GLOB.player_list)
		if(isliving(M))
			var/mob/living/L = M
			if(L.client)
				SSdroning.kill_rain(L.client)
		if(iscarbon(M)) //Dry us off.
			var/mob/living/carbon/L = M
			spawn(rand(30, 50))
				L.remove_status_effect(/datum/status_effect/buff/wetness/damp)
				L.remove_status_effect(/datum/status_effect/buff/wetness/wet)
				L.remove_status_effect(/datum/status_effect/buff/wetness/drenched)
