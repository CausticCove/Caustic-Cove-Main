/obj/item/rogueweapon/thresher
	force = 10
	force_wielded = 15
	possible_item_intents = list(MACE_STRIKE)
	gripped_intents = list(/datum/intent/flailthresh,MACE_STRIKE)
	name = "thresher"
	desc = "A shredding tool for farmers."
	icon_state = "flail"
	icon = 'icons/roguetown/weapons/tools.dmi'
	item_state = "mace_greyscale"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	slot_flags = ITEM_SLOT_BACK
	wlength = 33
	gripsprite = TRUE
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	smeltresult = /obj/item/ingot/iron
	improvised = TRUE

/datum/intent/flailthresh
	name = "thresh"
	icon_state = "inthresh"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0
	no_attack = TRUE
	

/obj/item/rogueweapon/thresher/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.7,"sx" = -9,"sy" = 0,"nx" = 10,"ny" = 1,"wx" = -5,"wy" = 0,"ex" = 2,"ey" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -15,"sturn" = 12,"wturn" = 0,"eturn" = 354,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded") return list("shrink" = 0.8,"sx" = 4,"sy" = -8,"nx" = -3,"ny" = -9,"wx" = -2,"wy" = -6,"ex" = 7,"ey" = -7,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = -6,"wturn" = 7,"eturn" = -21,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onbelt") return list("shrink" = 0.7,"sx" = 5,"sy" = 2,"nx" = -1,"ny" = 2,"wx" = 0,"wy" = 4,"ex" = 1,"ey" = 3,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/obj/item/rogueweapon/thresher/afterattack(obj/target, mob/user, proximity)
	if(user.used_intent.type == /datum/intent/flailthresh)
		if(isturf(target.loc))
			var/turf/T = target.loc
			var/found = FALSE
			for(var/obj/item/natural/chaff/C in T)
				found = TRUE
				C.thresh()
			if(found)
				playsound(loc,"plantcross", 100, FALSE)
				playsound(loc,"smashlimb", 50, FALSE)
				user.visible_message(span_notice("[user] threshes the stalks!"), \
									span_notice("I thresh the stalks."))
			return
	..()

/obj/item/rogueweapon/sickle
	force = 10
	possible_item_intents = list(DAGGER_CUT)
	name = "sickle"
	desc = "Rusted blade, worn handle, symbol of toil."
	icon_state = "sickle"
	icon = 'icons/roguetown/weapons/tools.dmi'
	item_state = "crysknife"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	sharpness = IS_SHARP
	//dropshrink = 0.8
	wlength = 10
	slot_flags = ITEM_SLOT_HIP
	max_blade_int = 50
	smeltresult = /obj/item/ingot/iron
	improvised = TRUE

/obj/item/rogueweapon/sickle/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.6,"sx" = -9,"sy" = 1,"nx" = 12,"ny" = 1,"wx" = -5,"wy" = 1,"ex" = 4,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt") return list("shrink" = 0.5,"sx" = -2,"sy" = -3,"nx" = 3,"ny" = -3,"wx" = -2,"wy" = -3,"ex" = 3,"ey" = -2,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/hoe
	force = 10
	force_wielded = 15
	possible_item_intents = list(/datum/intent/pick)
	gripped_intents = list(/datum/intent/pick,SPEAR_BASH,TILL_INTENT)
	name = "hoe"
	desc = "A tool for tiling soil. It's all dirty and worn."
	icon_state = "hoe"
	slot_flags = ITEM_SLOT_BACK
	icon = 'icons/roguetown/weapons/tools.dmi'
	item_state = "pitchfork"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.8
	wlength = 33
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	smeltresult = /obj/item/ingot/iron
	var/hoe_damage = null //the durability damage recieved for every work cycle
	var/work_time = 3 SECONDS // the time it takes to make new soil or till soil
	improvised = TRUE

/obj/item/rogueweapon/hoe/stone
	force = 7
	force_wielded = 12
	name = "stone hoe"
	desc = "A makeshift hoe made out of stone, brittle."
	icon_state = "stonehoe"
	//dropshrink = 0.8
	smeltresult = null
	anvilrepair = null
	max_integrity = 100
	hoe_damage = 25
	work_time = 15 SECONDS


/obj/item/rogueweapon/hoe/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,
"sx" = -11,
"sy" = 1,
"nx" = 12,
"ny" = 0,
"wx" = -7,
"wy" = -0,
"ex" = 6,
"ey" = 3,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 0,
"nturn" = -15,
"sturn" = 12,
"wturn" = 0,
"eturn" = 354,
"nflip" = 0,
"sflip" = 8,
"wflip" = 8,
"eflip" = 0)
			if("wielded")
				return list("shrink" = 0.8,
"sx" = 4,
"sy" = -6,
"nx" = -8,
"ny" = -6,
"wx" = 2,
"wy" = -6,
"ex" = 5,
"ey" = -3,
"northabove" = 0,
"southabove" = 1,
"eastabove" = 1,
"westabove" = 1,
"nturn" = -40,
"sturn" = 40,
"wturn" = 60,
"eturn" = 25,
"nflip" = 8,
"sflip" = 0,
"wflip" = 0,
"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/rogueweapon/hoe/attack_turf(turf/T, mob/living/user)
	if(user.used_intent.type == /datum/intent/till)
		if(user.mind.get_skill_level(/datum/skill/labor/farming) == SKILL_LEVEL_LEGENDARY) //check if the user has legendary farming skill
			work_time = 0.5 SECONDS //if legendary skill, do_afters take half a second instead of 3

		user.changeNext_move(CLICK_CD_MELEE)
		if(istype(T, /turf/open/floor/rogue/snow) || istype(T, /turf/open/floor/rogue/snowrough) || istype(T, /turf/open/floor/rogue/snowpatchy))
			playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			if (do_after(user, work_time, target = src))
				apply_farming_fatigue(user, 10)
				if(hoe_damage)
					to_chat(user,span_warning("[src] degrades."))
					src.take_damage(hoe_damage, BRUTE, "blunt")
				T.ChangeTurf(/turf/open/floor/rogue/grasscold, flags = CHANGETURF_INHERIT_AIR)
				playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			return
		if(istype(T, /turf/open/floor/rogue/grass) || istype(T, /turf/open/floor/rogue/grassred) || istype(T, /turf/open/floor/rogue/grassyel) || istype(T, /turf/open/floor/rogue/grasscold))
			playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			if (do_after(user, work_time, target = src))
				apply_farming_fatigue(user, 10)
				if(hoe_damage)
					to_chat(user,span_warning("[src] degrades."))
					src.take_damage(hoe_damage, BRUTE, "blunt")
				T.ChangeTurf(/turf/open/floor/rogue/dirt, flags = CHANGETURF_INHERIT_AIR)
				playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			return
		if(istype(T, /turf/open/floor/rogue/dirt))
			playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
			if(do_after(user, work_time, target = src))	
				playsound(T,'sound/items/dig_shovel.ogg', 100, TRUE)
				var/obj/structure/soil/soil = get_soil_on_turf(T)
				if(soil)
					soil.user_till_soil(user)
					if(hoe_damage)
						to_chat(user,span_warning("[src] degrades."))
						src.take_damage(hoe_damage, BRUTE, "blunt")
				else
					apply_farming_fatigue(user, 10)
					if(hoe_damage)
						to_chat(user,span_warning("[src] degrades."))
						src.take_damage(hoe_damage, BRUTE, "blunt")
					new /obj/structure/soil(T)
			return
	. = ..()

/datum/intent/till
	name = "hoe"
	icon_state = "inhoe"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0

/*
//make this attack_turf instead
/obj/item/rogueweapon/hoe/afterattack(obj/target, mob/user, proximity)
	if((!proximity) || (!wielded))
		return ..()

	if(istype(target, /turf/open/floor/rogue/dirt))
		var/obj/machinery/crop/R = locate() in target
		if(R)
			to_chat(user,span_warning("There's already a mound here."))
			return
		if(prob(10)) //ROGTODO make this farming skill based maybe a stat too
			user.visible_message(span_notice("[user] tills the soil!"), \
								span_notice("I till the soil."))
			new /obj/machinery/crop(target)
		else
			to_chat(user,span_warning("I till the soil."))
		return
	..()
*/
/obj/item/rogueweapon/pitchfork

	force = 10
	force_wielded = 15
	possible_item_intents = list(SPEAR_BASH)
	gripped_intents = list(SPEAR_BASH,SPEAR_THRUST,DUMP_INTENT)
	name = "pitchfork"
	desc = "Iron tines on a sturdy shaft essential for farmlike labour."
	icon_state = "pitchfork"
	icon = 'icons/roguetown/weapons/tools.dmi'
	item_state = "pitchfork"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	sharpness = IS_BLUNT
	associated_skill = /datum/skill/combat/polearms
	//dropshrink = 0.8
	wlength = 33
	var/list/forked = list()
	slot_flags = ITEM_SLOT_BACK
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	smeltresult = /obj/item/ingot/iron
/obj/item/rogueweapon/pitchfork/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen") return list("shrink" = 0.7,"sx" = -9,"sy" = 2,"nx" = 10,"ny" = 2,"wx" = -6,"wy" = 1,"ex" = 3,"ey" = 1,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -15,"sturn" = 12,"wturn" = 0,"eturn" = 354,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("wielded") return list("shrink" = 0.8,"sx" = 7,"sy" = -3,"nx" = -6,"ny" = -2,"wx" = -3,"wy" = -2,"ex" = 7,"ey" = -2,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = -38,"sturn" = 39,"wturn" = -35,"eturn" = 27,"nflip" = 8,"sflip" = 0,"wflip" = 8,"eflip" = 0)
			if("onback") return list("shrink" = 0.7,"sx" = 1,"sy" = 3,"nx" = -1,"ny" = 3,"wx" = 4,"wy" = 3,"ex" = -3,"ey" = 3,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 8,"sflip" = 0,"wflip" = 0,"eflip" = 8,"northabove" = 1,"southabove" = 0,"eastabove" = 0,"westabove" = 0)

/datum/intent/pforkdump
	name = "scoop"
	icon_state = "inscoop"
	chargetime = 0
	noaa = TRUE
	candodge = FALSE
	misscost = 0
	no_attack = TRUE

/obj/item/rogueweapon/pitchfork/afterattack(obj/target, mob/user, proximity)
	if((!proximity) || (!wielded))
		return ..()
	testing("fuck")
	if(isopenturf(target))
		if(forked.len)
			for(var/obj/item/I in forked)
				I.forceMove(target)
				forked -= I
			to_chat(user, span_warning("I dump the stalks."))
		update_icon()
		return
	..()

/obj/item/rogueweapon/pitchfork/ungrip(mob/living/carbon/user, show_message = TRUE)
	if(forked.len)
		var/turf/T = get_turf(user)
		for(var/obj/item/I in forked)
			I.forceMove(T)
			forked -= I
		update_icon()
	..()

/obj/item/rogueweapon/pitchfork/update_icon()
	if(forked.len)
		icon_state = "pitchforkstuff"
	else
		icon_state = initial(icon_state)
	..()
