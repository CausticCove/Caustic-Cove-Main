/mob/living/gib(no_brain, no_organs, no_bodyparts)
	var/prev_lying = lying
	if(stat != DEAD)
		death(TRUE)
	if(client)
		SSdroning.kill_droning(client)
	playsound(src.loc, pick('sound/combat/gib (1).ogg','sound/combat/gib (2).ogg'), 200, FALSE, 3)

	if(!prev_lying)
		gib_animation()

	spill_embedded_objects()
	
	spill_organs(no_brain, no_organs, no_bodyparts)

	if(!no_bodyparts)
		spread_bodyparts(no_brain, no_organs)

	spawn_gibs(no_bodyparts)
	qdel(src)

/mob/living/proc/gib_animation()
	return

/mob/living/proc/spawn_gibs()
	new /obj/effect/gibspawner/generic(drop_location(), src, get_static_viruses())

/mob/living/proc/spill_embedded_objects()
	for(var/obj/item/embedded_item as anything in simple_embedded_objects)
		simple_remove_embedded_object(embedded_item)

/mob/living/proc/spill_organs()
	return

/mob/living/proc/spread_bodyparts()
	return

/mob/living/dust(just_ash, drop_items, force)
	death(TRUE)

	spill_embedded_objects()

	if(drop_items)
		unequip_everything()
	
	if(buckled)
		buckled.unbuckle_mob(src, force = TRUE)

	dust_animation()
	spawn_dust(just_ash)
	QDEL_IN(src,5) // since this is sometimes called in the middle of movement, allow half a second for movement to finish, ghosting to happen and animation to play. Looks much nicer and doesn't cause multiple runtimes.

/mob/living/proc/dust_animation()
	return

/mob/living/proc/spawn_dust(just_ash = FALSE)
	for(var/i in 1 to 3)
		new /obj/item/ash(loc)


/mob/living/death(gibbed)
	var/was_dead_before = stat == DEAD
	stat = DEAD
	unset_machine()
	timeofdeath = world.time
	tod = station_time_timestamp()
//	var/turf/T = get_turf(src)
	for(var/obj/item/I in contents)
		I.on_mob_death(src, gibbed)
//	if(mind && mind.name && mind.active && !istype(T.loc, /area/ctf))
//		deadchat_broadcast(" has died at <b>[get_area_name(T)]</b>.", "<b>[mind.name]</b>", follow_target = src, turf_target = T, message_type=DEADCHAT_DEATHRATTLE)
//	if(mind)
//		mind.store_memory("Time of death: [tod]", 0)
	GLOB.alive_mob_list -= src
	if(!gibbed && !was_dead_before)
		GLOB.dead_mob_list += src

//	stop_all_loops()
	SSdroning.kill_rain(src.client)
	SSdroning.kill_loop(src.client)
	SSdroning.kill_droning(src.client)
	src.playsound_local(src, 'sound/misc/deth.ogg', 100)

	set_drugginess(0)
	set_disgust(0)
	cure_holdbreath()
	SetSleeping(0, 0)
	reset_perspective(null)
	reload_fullscreen()
	update_action_buttons_icon()
	update_damage_hud()
	update_health_hud()
	update_mobility()
	med_hud_set_health()
	med_hud_set_status()
	if(!gibbed && !QDELETED(src))
		addtimer(CALLBACK(src, PROC_REF(med_hud_set_status)), (DEFIB_TIME_LIMIT * 10) + 1)
	stop_pulling()

	. = ..()

	if(client)
		client.move_delay = initial(client.move_delay)
		var/atom/movable/screen/gameover/hog/H = new()
		H.layer = SPLASHSCREEN_LAYER+0.1
		client.screen += H
//		flick("gameover",H)
//		addtimer(CALLBACK(H, TYPE_PROC_REF(/atom/movable/screen/gameover, Fade)), 29)
		H.Fade()
		mob_timers["lastdied"] = world.time
		addtimer(CALLBACK(H, TYPE_PROC_REF(/atom/movable/screen/gameover, Fade), TRUE), 100)
//		addtimer(CALLBACK(client, PROC_REF(ghostize), 1, src), 150)
		add_client_colour(/datum/client_colour/monochrome)
		client.verbs.Add(GLOB.ghost_verbs)

	for(var/s in ownedSoullinks)
		var/datum/soullink/S = s
		S.ownerDies(gibbed)
	for(var/s in sharedSoullinks)
		var/datum/soullink/S = s
		S.sharerDies(gibbed)

//	for(var/datum/death_tracker/D in target.death_trackers)

	if(!gibbed && rot_type)
		LoadComponent(rot_type)

	set_typing_indicator(FALSE)

	// AZURE EDIT BEGIN: necra acolyte/priest deathsight trait
	// this was a player that just died, so do the honors
	if (client)
		if (!gibbed)
			var/locale = prepare_deathsight_message()
			for (var/mob/living/player in GLOB.player_list)
				if (player.stat == DEAD || isbrain(player))
					continue
				if (HAS_TRAIT(player, TRAIT_DEATHSIGHT))
					if (HAS_TRAIT(player, TRAIT_CABAL))
						to_chat(player, span_warning("I feel the faint passage of disjointed life essence as it flees [locale]."))
					else
						to_chat(player, span_warning("Veiled whispers herald the Undermaiden's gaze in my mind's eye as it turn towards [locale] for but a brief, singular moment."))
	// AZURE EDIT END

	return TRUE

/mob/living/proc/prepare_deathsight_message()
	var/area_of_death = lowertext(get_area_name(src))
	var/locale = "a locale wreathed in enigmatic fog"
	switch (area_of_death) // we're deliberately obtuse with this.
		if ("mountains", "mt decapitation")
			locale = "a twisted tangle of soaring peaks"
		if ("wilderness", "azure basin")
			locale = "somewhere in the wilds"
		if ("bog", "dense bog")
			locale = "a wretched, fetid bog"
		if ("coast", "coastforest")
			locale = "somewhere betwixt Abyssor's realm and Dendor's bounty"
		if ("indoors", "shop", "physician", "outdoors", "roofs", "manor", "wizard's tower", "garrison", "dungeon cell", "baths", "tavern")
			locale = "the city of Azure Peak and all its bustling souls"
		if ("church")
			locale = "a hallowed place, sworn to the Ten" // special bit for the church since it's sacred ground
	
	return locale
