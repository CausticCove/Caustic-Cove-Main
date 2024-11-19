/mob/living/simple_animal/hostile/retaliate/rogue/wendigo_beast
	icon = 'modular_causticcove/icons/monsters/64x64monsters.dmi'
	name = "wendigo beast"
	icon_state = "wendigo_noblood"
	var/icon_half_hp = "wendigo"
	icon_living = "broodmother"
	icon_dead = "wendigo_dead"
	gender = MALE
	emote_hear = null	
	emote_see = null
	speak_chance = 1
	turns_per_move = 2
	see_in_dark = 12
	move_to_delay = 3
	pixel_x = -16
	base_intents = list(/datum/intent/simple/claw)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 4,
						/obj/item/natural/hide = 4,
						/obj/item/natural/fur = 4,
						/obj/item/natural/bone = 4,
						/obj/item/natural/alchemy/antler = 2)
	faction = list("wendigo")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST|MOB_EPIC
	//We attack very fast and deal damage by exhausting our opponents. They must learn how to fight against speed
	melee_damage_lower = 10
	melee_damage_upper = 15
	vision_range = 9
	//We are deranged hunters who will feast on anyone, and anything.
	aggro_vision_range = 12
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	health = 750
	maxHealth = 750
	STACON = 13
	STAEND = 13
	STASTR = 18
	STASPD = 6
	deaggroprob = 0
	simple_detect_bonus = 20
	defprob = 10
	//Blocking an attack against this thing is like hitting a rock with all of your might.
	defdrain = 50
	//We are a major threat.
	del_on_deaggro = 9999 SECONDS
	//We never back down from our prey.
	retreat_health = 0
	food = 0
	attack_sound = list('sound/blank.ogg')
	dodgetime = 66
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	var/stagetwo = 0
	var/allow_ability = 0
	var/ability_cd = 0

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo_beast/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_BLOODLOSS_IMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BASHDOORS, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_ORGAN_EATER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOROGSTAM, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	
/mob/living/simple_animal/hostile/retaliate/rogue/wendigo_beast/proc/enter_stage_two()
	src.move_to_delay = 2
	src.turns_per_move = 1
	//We heal to full now! Effective total HP roughly 750. Fire damage is permanent.
	src.adjustBruteLoss(-maxHealth)
	playsound(src, 'modular_causticcove/sound/mobs/gut_mucher_stage_two.ogg', 100, TRUE)
	src.allow_ability = TRUE

//This ability is fucked. I know it's fucked. But I cannot for the life of me figure out how to lock them in place.
/mob/living/simple_animal/hostile/retaliate/rogue/wendigo_beast/proc/rend_ability()
	ability_cd = 20
	var/list/targets = oview(1, src)
	for(var/mob/living/T in targets)
		visible_message(span_warningbig("The [src] pins [T] to the ground!"))
		face_atom(T)
		T.Stun(90)
		T.emote("scream")
		for(var/i in 1 to 12)
			if(do_after(src, 3))
				T.attack_animal(src)
				src.adjustBruteLoss(-10)
				src.blood_volume += 20
				if(prob(50))
					T.emote("scream")
		targets = list()

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo_beast/Life()
	. = ..()
	if(health <= (maxHealth/2) && !stagetwo)
		src.stagetwo++
		src.icon_state = icon_half_hp
		enter_stage_two()
	if(prob(25))
		if(src.ability_cd <= 0 && src.allow_ability)
			rend_ability()
	ability_cd--

/mob/living/simple_animal/hostile/retaliate/rogue/wendigo_beast/AttackingTarget()
	. = ..()
	if(prob(50))
		src.adjustBruteLoss(-5)
