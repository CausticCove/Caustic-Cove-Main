/obj/item/fishingrod
	force = 12
	possible_item_intents = list(ROD_CAST,SPEAR_BASH)
	name = "fishing rod"
	desc = "Made from weathered wood and coarse twine. The tool of the battle against the dark waters below."
	icon_state = "rod"
	icon = 'icons/roguetown/weapons/tools.dmi'
	sharpness = IS_BLUNT
	wlength = 33
	var/obj/item/baited = null
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_HIP
	w_class = WEIGHT_CLASS_BULKY

/datum/intent/cast
	name = "cast"
	chargetime = 0
	noaa = TRUE
	misscost = 0
	icon_state = "inuse"
	no_attack = TRUE

/obj/item/fishingrod/attack_self(mob/user)
	if(user.doing)
		user.doing = 0
	else
		..()


/obj/item/fishingrod/attackby(obj/item/I, mob/user, params)
	if(baited)
		to_chat(user, span_warning("The rod already has bait on it!"))
		return
	if(!I.isbait) // Don't use items that aren't bait
		to_chat(user, span_notice("This isn't suitable as bait..."))
		return
	user.visible_message(span_notice("[user] hooks something to the line."), \
						span_notice("I hook [I] to my line."))
	playsound(src.loc, 'sound/foley/pierce.ogg', 50, FALSE)
	if(istype(I,/obj/item/natural/worms))
		var/obj/item/natural/worms/W = I
		if(W.amt > 1)
			W.amt--
			var/obj/item/natural/worms/N = new W.type(src)
			baited = N
		else
			W.forceMove(src)
			baited = W
	else
		I.forceMove(src)
		baited = I
	update_icon()

/obj/item/fishingrod/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.7,"sx" = -14,"sy" = 3,"nx" = 14,"ny" = 3,"wx" = -12,"wy" = 4,"ex" = 6,"ey" = 5,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/fishingrod/afterattack(obj/target, mob/user, proximity)
	var/sl = user.mind.get_skill_level(/datum/skill/labor/fishing) // User's skill level
	var/ft = 120 //Time to get a catch, in ticks
	var/fpp =  100 - (40 + (sl * 10)) // Fishing power penalty based on fishing skill level
	if(user.used_intent.type == SPEAR_BASH)
		return ..()

	if(!check_allowed_items(target,target_self=1))
		return ..()

	if(istype(target, /turf/open/water))
		if(user.used_intent.type == ROD_CAST && !user.doing)
			if(target in range(user,5))
				user.visible_message("<span class='warning'>[user] casts a line!</span>", \
									"<span class='notice'>I cast a line.</span>")
				playsound(src.loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
				ft -= (sl * 20) //every skill lvl is -2 seconds
				ft = max(20,ft) //min of 2 seconds
				if(do_after(user,ft, target = target))
					if(baited)
						var/bp = baited.baitpenalty // Penalty to fishing chance based on how good bait is. Lower is better.
						var/fishchance = 100 // Total fishing chance, deductions applied below
						if(user.mind)
							if(!sl) // If we have zero fishing skill...
								fishchance -= 50 // 50% chance to fish base
							else
								fishchance -= bp // Deduct penalties from bait quality, if any
								fishchance -= fpp // Deduct a penalty the lower our fishing level is (-0 at legendary)
						var/mob/living/fisherman = user
						if(prob(fishchance)) // Finally, roll the dice to see if we fish.
							var/A = pickweight(baited.fishloot)
							var/ow = 30 + (sl * 10) // Opportunity window, in ticks. Longer means you get more time to cancel your bait
							to_chat(user, "<span class='notice'>Something tugs the line!</span>")
							playsound(src.loc, 'sound/items/fishing_plouf.ogg', 100, TRUE)
							if(!do_after(user,ow, target = target))
								if(ismob(A)) // TODO: Baits with mobs on their fishloot lists OR water tiles with their own fish loot pools
									var/mob/M = A
									if(M.type in subtypesof(/mob/living/simple_animal/hostile))
										new M(target)
									else
										new M(user.loc)
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, fisherman.STAINT*2) // High risk high reward
								else
									new A(user.loc)
									to_chat(user, "<span class='warning'>Reel 'em in!</span>")
									user.mind.add_sleep_experience(/datum/skill/labor/fishing, round(fisherman.STAINT, 2), FALSE) // Level up!
								playsound(src.loc, 'sound/items/Fish_out.ogg', 100, TRUE)
								if(prob(80 - (sl * 10))) // Higher skill levels make you less likely to lose your bait
									to_chat(user, "<span class='warning'>Damn, it ate my bait.</span>")
									qdel(baited)
									baited = null
							else
								to_chat(user, "<span class='warning'>Damn, it got away... I should <b>pull away</b> next time.</span>")
								if(prob(100 - (sl * 10))) // Higher chance for it to flee with your bait.
									to_chat(user, "<span class='warning'>...And took my bait, too.</span>")
									qdel(baited)
									baited = null
						else
							to_chat(user, "<span class='warning'>Not even a nibble...</span>")
							user.mind.add_sleep_experience(/datum/skill/labor/fishing, fisherman.STAINT/2) // Pity XP.
					else
						to_chat(user, "<span class='warning'>This seems pointless without bait.</span>")
				else
					to_chat(user, "<span class='warning'>I must stand still to fish.</span>")
			update_icon()

/obj/item/fishingrod/update_icon()
	cut_overlays()
	if(baited)
		var/obj/item/I = baited
		I.pixel_x = 6
		I.pixel_y = -6
		add_overlay(new /mutable_appearance(I))
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
