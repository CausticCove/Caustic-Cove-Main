/mob/living/simple_animal/hostile/retaliate/rogue/brain_gusher_beast
	icon = 'modular_causticcove/icons/monsters/lavaland_monsters.dmi'
	name = "brain gusher beast"
	icon_state = "curseblob"
	icon_living = "curseblob"
	icon_dead = null
	gender = NEUTER
	emote_hear = null	
	emote_see = null
	speak_chance = 1
	turns_per_move = 4
	see_in_dark = 1
	move_to_delay = 4
	base_intents = list(/datum/intent/unarmed/claw)
	butcher_results = list(/obj/item/reagent_containers/powder/moondust = 3)
	faction = list("hallucination")
	mob_biotypes = MOB_BEAST
	melee_damage_lower = 1
	melee_damage_upper = 10
	vision_range = 12
	aggro_vision_range = 12
	environment_smash = ENVIRONMENT_SMASH_NONE
	retreat_distance = 0
	minimum_distance = 0
	milkies = FALSE
	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	pooptype = null
	health = 35
	maxHealth = 35
	STACON = 7
	STAEND = 7
	STASTR = 5
	STASPD = 15
	deaggroprob = 33
	simple_detect_bonus = 20
	defprob = 40
	defdrain = 0
	del_on_deaggro = 120 SECONDS
	retreat_health = 0
	food = 0
	attack_sound = list('sound/misc/vcraft.ogg')
	dodgetime = 9999
	aggressive = 1
//	stat_attack = UNCONSCIOUS

//We make people a little crazy...
/mob/living/simple_animal/hostile/retaliate/rogue/brain_gusher_beast/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/carbon/L = target
		//Lie down and FACE YOUR FEARS!!! In other words, attack while prone.
		if((L.mobility_flags & MOBILITY_STAND) && !L.has_status_effect(/datum/status_effect/buff/induced_insanity))
			L.Knockdown(20)
			L.emote("laugh")
			L.apply_status_effect(/datum/status_effect/buff/induced_insanity)

/mob/living/simple_animal/hostile/retaliate/rogue/brain_gusher_beast/death(gibbed)
	//How many are there...?!
	. = ..()
	if(prob(25))
		new /mob/living/simple_animal/hostile/retaliate/rogue/brain_gusher_beast(src)
		playsound(src, 'sound/misc/zizo.ogg', 75, TRUE)
		qdel(src)
		return
	else
		playsound(src, 'sound/misc/zizo.ogg', 25, FALSE)
		new /obj/item/reagent_containers/powder/moondust(src)
		qdel(src)
