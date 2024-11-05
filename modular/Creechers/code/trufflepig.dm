/*  * * * * * * * * * * * * * * * * * * * * * * * * *
 *													*		Animal that can locate hidden truffles in bog area dirt turf
 *					TRUFFLE PIG						*		Dig them up with a shovel, pig will demand truffles eventually or stop working
 *					 								*		Meant to help locate some extra food in the wilderness
 *													*
 * * * * * * * * * * * * * * * * * * * * * * * * * * */


//	........   Dirt changes   ................
/turf/open/floor/rogue/dirt //truffles, var needed for the sniffing function
	var/hidden_truffles
	var/hidden_toxicshrooms

/turf/open/floor/rogue/dirt/Initialize()
	. = ..()
	if(istype(loc, /area/rogue/outdoors/woods))
		if(!((locate(/obj/structure) in src) || (locate(/obj/machinery) in src)))
			if(prob(4))
				hidden_truffles = TRUE
			else if(prob(1))
				hidden_toxicshrooms = FALSE
			return

/turf/open/floor/rogue/dirt/attackby(obj/item/W, mob/user, params)
	if(hidden_truffles)
		if(istype(W, /obj/item/rogueweapon/shovel))
			playsound(get_turf(src),'sound/items/dig_shovel.ogg', 70, TRUE)
			if(user.used_intent.type == /datum/intent/shovelscoop)
				if(do_after(user, 3 SECONDS, target = src))
					new /obj/item/reagent_containers/food/snacks/rogue/truffles(get_turf(src))
					hidden_truffles = FALSE
	if(hidden_toxicshrooms)
		if(istype(W, /obj/item/rogueweapon/shovel))
			playsound(get_turf(src),'sound/items/dig_shovel.ogg', 70, TRUE)
			if(user.used_intent.type == /datum/intent/shovelscoop)
				if(do_after(user, 3 SECONDS, target = src))
					new /obj/item/reagent_containers/food/snacks/rogue/toxicshrooms(get_turf(src))
					hidden_toxicshrooms = FALSE
	else ..()


//	........   Truffles   ................
/obj/item/reagent_containers/food/snacks/rogue/truffles
	name = "truffles"
	icon = 'modular/Creechers/icons/piggie.dmi'
	icon_state = "mushroom1_full"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/truffles/cooked
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/truffles/cooked
	color = "#ab7d6f"
	tastes = list("mushroom" = 1)
	sellprice = 5
/obj/item/reagent_containers/food/snacks/rogue/truffles/cooked
	eat_effect = /datum/status_effect/buff/foodbuff
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	color = "#835b4f"
	tastes = list("succulent truffles" = 1)
/obj/item/reagent_containers/food/snacks/rogue/truffles/Initialize()
	icon_state = pick("mushroom1_full","mushroom1_full","mushroom1_full")
	. = ..()

/obj/item/reagent_containers/food/snacks/rogue/toxicshrooms
	name = "truffles"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "mushroom1_full"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/rogue/toxicshrooms/cooked
	fried_type = /obj/item/reagent_containers/food/snacks/rogue/toxicshrooms/cooked
	color = "#ab7d6f"
	tastes = list("mushroom" = 1)
/obj/item/reagent_containers/food/snacks/rogue/toxicshrooms/cooked
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	color = "#835b4f"
/obj/item/reagent_containers/food/snacks/rogue/toxicshrooms/Initialize()
	icon_state = pick("mushroom1_full","mushroom1_full","mushroom1_full")
	. = ..()

//	........   Truffle Pig   ................
/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig
	icon = 'modular/Creechers/icons/piggie.dmi'
	name = "truffle pig"
	desc = "A hairy pig, bred for finding truffles in the bog."
	icon_state = "piggie_m"
	icon_living = "piggie_m"
	icon_dead = "piggie_dead"
	icon_gib = "piggie_dead"
	gender = MALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	emote_see = list("eyes the surroundings.", "flicks its ears.")
	stop_automated_movement_when_pulled = TRUE
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	move_to_delay = 7
	animal_species = /mob/living/simple_animal/hostile/retaliate/rogue/trufflepig
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/fatty = 4,
						/obj/item/reagent_containers/food/snacks/fat = 2,
						/obj/item/natural/hide = 2)
	base_intents = list(/datum/intent/simple/headbutt)
	health = 80
	maxHealth = 80
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/truffles)
	footstep_type = FOOTSTEP_MOB_SHOE
	pooptype = /obj/item/natural/poo/horse
	faction = list("goats")
	attack_verb_continuous = "bites"
	attack_verb_simple = "bites"
	melee_damage_lower = 8
	melee_damage_upper = 14
	minimum_distance = 1
	STASPD = 2
	STACON = 8
	STASTR = 12
	can_buckle = FALSE
	buckle_lying = 0
	can_saddle = FALSE
	remains_type = /obj/effect/decal/remains/pig
	response_help_continuous = "pets"
	response_help_simple = "give the signal to the"
	var/hangry_meter = 0


/obj/effect/decal/remains/pig
	name = "remains"
	gender = PLURAL
	icon_state = "skele"
	icon = 'icons/roguetown/mob/monster/cow.dmi'

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/Life()
	. = ..()
	if((src.loc) && isturf(src.loc))
		for(var/obj/item/reagent_containers/food/snacks/rogue/truffles/M in view(1,src))
			if(Adjacent(M))
				walk_towards(src, M, 1)
				sleep(3)
				visible_message("<span class='notice'>The pig devours the vulnerable truffles!</span>")
				stop_automated_movement = 0
				hangry_meter = 0
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				qdel(M)
				break

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/attack_hand(mob/living/carbon/human/M)
	. = ..()
	hangry_meter += 1
	if(hangry_meter > 9)
		to_chat(M, "<span class='notice'>The pig squeals in anger. Its sulking and refusing to work until it gets delicious truffles.</span>")
		playsound(get_turf(src), 'modular/Creechers/sound/pighangry.ogg', 150, TRUE, -1)
		return
	if(M.used_intent.type == INTENT_HELP)
		playsound(get_turf(src), pick('modular/Creechers/sound/pig1.ogg','modular/Creechers/sound/pig2.ogg'), 100, TRUE, -1)
		dir = pick(GLOB.cardinals)
		step(src, dir)
		playsound(src, 'sound/items/sniff.ogg', 60, FALSE)
		sleep(10)
		dir = pick(GLOB.cardinals)
		step(src, dir)
		playsound(src, 'sound/items/sniff.ogg', 60, FALSE)
		sleep(10)
		dir = pick(GLOB.cardinals)
		playsound(get_turf(src), pick('modular/Creechers/sound/pig1.ogg','modular/Creechers/sound/pig2.ogg'), 100, TRUE, -1)
		var/turf/t = get_turf(src)
		trufflesearch(t, 5)

/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/reagent_containers/food/snacks/rogue/truffles))
		visible_message("<span class='notice'>The pig munches the truffles, looking happy.</span>")
		hangry_meter = 0
		playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(O)
	if(istype(O, /obj/item/reagent_containers/food/snacks/rogue/toxicshrooms))
		visible_message("<span class='notice'>The pig munches the truffles reluctantly.</span>")
		playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(O)
		playsound(get_turf(src), 'modular/Creechers/sound/pighangry.ogg', 130, TRUE, -1)
		sleep(20)
		playsound(get_turf(src), 'modular/Creechers/sound/pighangry.ogg', 130, TRUE, -1)
		visible_message("<span class='notice'>The pig shivers.</span>")
		sleep(10)
		death()
	else
		return ..()


//	........   Truffle Search   ................
/mob/living/simple_animal/hostile/retaliate/rogue/trufflepig/proc/trufflesearch(turf/T, range = world.view)
	var/list/found_stuff = list()
	for(var/turf/open/floor/rogue/dirt/M in range(range, T))
		if(M.hidden_truffles)
			found_stuff += M
	if(LAZYLEN(found_stuff))
		for(var/turf/open/floor/rogue/dirt/M in found_stuff)
			var/obj/effect/temp_visual/truffle_overlay/oldC = locate(/obj/effect/temp_visual/truffle_overlay) in M
			if(oldC)
				qdel(oldC)
			new /obj/effect/temp_visual/truffle_overlay(M)

/obj/effect/temp_visual/truffle_overlay
	plane = FULLSCREEN_PLANE
	layer = FLASH_LAYER
	icon = 'modular/Creechers/icons/trufflesniff.dmi'
	icon_state = "foundsome"
	appearance_flags = 0 //to avoid having TILE_BOUND in the flags, so that the 480x480 icon states let you see it no matter where you are
	duration = 35
	pixel_x = -224
	pixel_y = -224
