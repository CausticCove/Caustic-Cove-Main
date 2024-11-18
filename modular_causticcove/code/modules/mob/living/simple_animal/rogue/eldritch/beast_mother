/mob/living/simple_animal/hostile/retaliate/rogue/beast_mother
	icon = 'modular_causticcove/icons/monsters/lavaland_elites_64.dmi'
	name = "broodmother beast"
	icon_state = "broodmother"
	icon_living = "broodmother"
	icon_dead = "egg_sac"
	gender = FEMALE
	emote_hear = null	
	emote_see = null
	speak_chance = 1
	turns_per_move = 3
	see_in_dark = 1
	move_to_delay = 6
	pixel_x = -16
	base_intents = list(/datum/intent/simple/headbutt)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
						/obj/item/natural/hide = 4,
						/obj/item/natural/fur = 1)
	faction = list("eldritch")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_EPIC
	melee_damage_lower = 9
	melee_damage_upper = 19
	vision_range = 5
	aggro_vision_range = 6
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	//Protect the babies!
	health = 166
	maxHealth = 166
	STACON = 16
	STAEND = 16
	STASTR = 5
	STASPD = 4
	deaggroprob = 33
	simple_detect_bonus = 20
	defprob = 33
	defdrain = 30
	del_on_deaggro = 120 SECONDS
	retreat_health = 0.6
	food = 0
	attack_sound = list('sound/blank.ogg')
	dodgetime = 66
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/mob/living/simple_animal/hostile/retaliate/rogue/beast_mother_bab
//Wee little babs.
	name = "Beastie"
	health = 15
	maxHealth = 15
	STACON = 3
	STAEND = 3
	STASTR = 2
	STASPD = 12
	melee_damage_lower = 5
	melee_damage_upper = 15
	icon = 'modular_causticcove/icons/monsters/lavaland_monsters.dmi'
	icon_state = "goliath_baby"
	icon_living = "goliath_baby"
	icon_dead = "goliath_baby_dead"
	var/icon_crying = "goliath_baby_cry"
	var/icon_enraged = "goliath_baby_enraged"
	gender = FEMALE
	emote_hear = null	
	emote_see = null
	speak_chance = 1
	turns_per_move = 2
	see_in_dark = 1
	move_to_delay = 4
	base_intents = list(/datum/intent/simple/headbutt)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 1,
						/obj/item/natural/hide = 1)
	faction = list("eldritch")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	vision_range = 5
	aggro_vision_range = 6
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	deaggroprob = 33
	simple_detect_bonus = 20
	defprob = 50
	defdrain = 10
	del_on_deaggro = 120 SECONDS
	retreat_health = 0.5
	food = 0
	attack_sound = list('sound/blank.ogg')
	dodgetime = 20
	aggressive = 1
//	stat_attack = UNCONSCIOUS

/obj/effect/temp_visual/beastie_spawn_location
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "mini_leaper"
	duration = 10


//Make sure we aren't doing the same as the mother and gib upon death immediately.
/mob/living/simple_animal/hostile/retaliate/rogue/beast_mother_bab/death(gibbed)
	. = ..()
	gib()

/mob/living/simple_animal/hostile/retaliate/rogue/beast_mother_bab/Initialize()
	for(var/mob/living/simple_animal/D in range(2, get_turf(src)))
		if(istype(D, /mob/living/simple_animal/hostile/retaliate/rogue/beast_mother) && prob(77))
			if(D.stat == DEAD)
				cry_sequence()
	. = ..()

//Cry if we see mother is dead
/mob/living/simple_animal/hostile/retaliate/rogue/beast_mother_bab/proc/cry_sequence()
	if(prob(66))
		toggle_ai(AI_OFF)
		icon_state = icon_crying
		emote("cry")
		spawn(60)
			if(stat == CONSCIOUS)
				toggle_ai(AI_ON)
				icon_state = icon_living
				emote("growl")
				visible_message("Angry chirps can be heard!")
				//Momma's dead?! I'M GONNA FUCKING KILL YOU!!! (+5 damage bonus)
				melee_damage_lower = 10
				melee_damage_upper = 20
				name = "Upset Beastie"
				if(prob(3))
					//Main character syndrome. Huge damage, be afraid. But less dodge chance.
					visible_message(span_warningbig("A GUTTERAL CRY CAN BE HEARD!!!"))
					melee_damage_lower = 20
					melee_damage_upper = 40
					defprob = 25
					icon_state = icon_enraged
					name = "Enraged Beastie"
					desc = "It's a beautiful day outside. Birds are screeching, flowers are wilting... on days like these, adventurers like you... Should be burning in hell."
	else

//Spawn the beasties around the mother, make sure it's not in a wall
/mob/living/simple_animal/hostile/retaliate/rogue/beast_mother/death(gibbed)
 var/list/turfs = list()
 var/spawn_location 
	for(var/turf/T in view(1, get_turf(src)))
		if(isfloorturf(T))
			turfs += T
	for(var/i in 1 to rand(1,6))
		spawn(rand(0, 60))
			spawn_location = pick(turfs)
			new /obj/effect/temp_visual/beastie_spawn_location(pick(spawn_location))
			playsound(spawn_location, 'modular_causticcove/sound/mobs/eldritch/egghatching.ogg', 100, TRUE)
			spawn(10)
				new /mob/living/simple_animal/hostile/retaliate/rogue/beast_mother_bab(pick(spawn_location))
	. = ..()
	

