// T1: (fires a bone splinter at a target for brute and bleeding if you're not holding bones in your other hand, fires a significantly stronger bone lance if you are)

/obj/effect/proc_holder/spell/invoked/projectile/profane
	name = "Profane"
	desc = "Fire forth a splinter of unholy bone, tearing flesh and causing bleeding. If you hold pieces of bone in your other hand, you will coax a much stronger lance of bone into being."
	clothes_req = FALSE
	overlay_state = "profane"
	range = 8
	associated_skill = /datum/skill/magic/arcane
	projectile_type = /obj/projectile/magic/profane
	chargedloop = /datum/looping_sound/invokeholy
	releasedrain = 30
	chargedrain = 0
	chargetime = 15
	charge_max = 10 SECONDS

/obj/effect/proc_holder/spell/invoked/projectile/profane/miracle
	miracle = TRUE
	devotion_cost = 15
	associated_skill = /datum/skill/magic/holy

/obj/effect/proc_holder/spell/invoked/projectile/profane/fire_projectile(mob/living/user, atom/target)
	current_amount--

	var/obj/item/held_item = user.get_active_held_item()
	var/big_cast = FALSE
	if (istype(held_item, /obj/item/stack/sheet/bone))
		var/obj/item/stack/sheet/bone/bonez = held_item
		if (bonez.use(1))
			projectile_type = /obj/projectile/magic/profane/major
			big_cast = TRUE
	else if (istype(held_item, /obj/item/natural/bone))
		qdel(held_item)
		projectile_type = /obj/projectile/magic/profane/major
		big_cast = TRUE
	else if (istype(held_item, /obj/item/natural/bundle/bone))
		var/obj/item/natural/bundle/bone/boney_bundle = held_item
		if (boney_bundle.use(1))
			projectile_type = /obj/projectile/magic/profane/major
			big_cast = TRUE

	var/obj/projectile/P = new projectile_type(user.loc)
	P.firer = user
	P.preparePixelProjectile(target, user)
	P.fire()

	if (big_cast)
		user.visible_message(span_danger("[user] conjures and hurls a vicious lance of bone towards [target]!"), span_notice("I hurl forth a vicious lance of profaned bone at [target]!"))
	else
		user.visible_message(span_danger("[user] directs forth a splinter of bone towards [target]!"), span_notice("I fling forth a shard of profaned bone at [target]!"))

	projectile_type = initial(projectile_type)

/obj/projectile/magic/profane
	name = "profaned bone splinter"
	icon_state = "chronobolt"
	damage = 20
	damage_type = BRUTE
	nodamage = FALSE
	var/embed_prob = 10

/obj/projectile/magic/profane/major
	name = "profaned bone lance"
	damage = 35
	embed_prob = 30

/obj/projectile/magic/profane/on_hit(atom/target, blocked)
	. = ..()
	if (iscarbon(target) && prob(embed_prob))
		var/mob/living/carbon/carbon_target = target
		var/obj/item/bodypart/victim_limb = pick(carbon_target.bodyparts)
		var/obj/item/stack/sheet/bone/splinter/our_splinter = new
		victim_limb.add_embedded_object(our_splinter, FALSE, TRUE)

/obj/item/stack/sheet/bone/splinter
	name = "bone splinter"
	singular_name = "bone splinter"
	embedding = list(
		"embed_chance" = 100,
		"embedded_pain_chance" = 25,
		"embedded_fall_chance" = 5,
	)

/obj/item/stack/sheet/bone/splinter/dropped(mob/user, silent)
	. = ..()
	to_chat(user, span_danger("[src] crumbles into dust..."))
	qdel(src)

// T2: just use lesser animate undead for now

/obj/effect/proc_holder/spell/invoked/raise_lesser_undead/miracle
	miracle = TRUE
	devotion_cost = 75
	cabal_affine = TRUE

// T3: Rituos (usable once per sleep cycle, allows you to choose any 1 arcane spell to use for the duration w/ an associated devotion cost. each time you change it, 1 of your limbs is skeletonized, if all of your limbs are skeletonized, you gain access to arcane magic. continuing to use rituos after being fully skeletonized gives you additional spellpoints). Gives you the MOB_UNDEAD flag (needed for skeletonize to work) on first use.

/obj/effect/proc_holder/spell/invoked/rituos
	name = "Rituos"
	desc = "Draw upon the Lesser Work of She Who Is Z, and expunge the trappings of mortal flesh from your form in exchange for power unimaginable. Be warned: indulging in even the first step of this ritual will make you more deadite than not..."
	clothes_req = FALSE
	overlay_state = "rituos"
	associated_skill = /datum/skill/magic/arcane
	chargedloop = /datum/looping_sound/invokeholy
	chargedrain = 0
	chargetime = 50
	releasedrain = 90
	no_early_release = TRUE
	movement_interrupt = TRUE
	charge_max = 2 MINUTES
	var/list/excluded_bodyparts = list(/obj/item/bodypart/head)
	var/list/obj/effect/proc_holder/spell/spell_choices = list(/obj/effect/proc_holder/spell/invoked/projectile/fireball,
		/obj/effect/proc_holder/spell/invoked/projectile/lightningbolt,
		/obj/effect/proc_holder/spell/invoked/projectile/fetch,
		/obj/effect/proc_holder/spell/invoked/projectile/spitfire,
		/obj/effect/proc_holder/spell/invoked/forcewall_weak,
		/obj/effect/proc_holder/spell/invoked/slowdown_spell_aoe,
		/obj/effect/proc_holder/spell/self/message,
		/obj/effect/proc_holder/spell/invoked/push_spell,
		/obj/effect/proc_holder/spell/invoked/blade_burst,
		/obj/effect/proc_holder/spell/targeted/touch/nondetection,
		/obj/effect/proc_holder/spell/invoked/haste,
		/obj/effect/proc_holder/spell/invoked/featherfall,
		/obj/effect/proc_holder/spell/targeted/touch/darkvision,
		/obj/effect/proc_holder/spell/invoked/longstrider,
	)

/obj/effect/proc_holder/spell/invoked/rituos/miracle
	miracle = TRUE
	devotion_cost = 120
	associated_skill = /datum/skill/magic/holy

/obj/effect/proc_holder/spell/invoked/rituos/proc/check_ritual_progress(mob/living/carbon/user)
	var/rituos_complete = TRUE
	for (var/obj/item/bodypart/our_limb in user.bodyparts)
		if (our_limb.type in excluded_bodyparts)
			continue
		if (!our_limb.skeletonized)
			rituos_complete = FALSE
		
	return rituos_complete

/obj/effect/proc_holder/spell/invoked/rituos/proc/get_skeletonized_bodyparts(mob/living/carbon/user)
	var/skeletonized_parts = list()
	for (var/obj/item/bodypart/our_limb in user.bodyparts)
		if (our_limb.type in excluded_bodyparts)
			continue
		if (our_limb.skeletonized)
			skeletonized_parts += our_limb.type
	
	return skeletonized_parts

/obj/effect/proc_holder/spell/invoked/rituos/cast(list/targets, mob/living/carbon/user)
	//check to see if we're all skeletonized first
	var/pre_rituos = check_ritual_progress(user)
	if (pre_rituos)
		to_chat(user, span_notice("I have completed Her Lesser Work. Only lichdom awaits me now, but just out of reach..."))
		return FALSE

	if (user.mind?.has_rituos)
		to_chat(user, span_warning("I have not the mental fortitude to enact the Lesser Work again. I must rest first..."))
		return FALSE

	//hoo boy. here we go.
	var/list/possible_parts = user.bodyparts.Copy()
	var/list/skeletonized_parts = get_skeletonized_bodyparts(user)

	for(var/obj/item/bodypart/BP in possible_parts)
		for(var/bodypart_type in excluded_bodyparts)
			if(istype(BP, bodypart_type))
				possible_parts -= BP
				break
		for(var/skeleton_part in skeletonized_parts)
			if (istype(BP, skeleton_part))
				possible_parts -= BP
				break

	var/obj/item/bodypart/the_part = pick(possible_parts)
	var/obj/item/bodypart/part_to_bonify = user.get_bodypart(the_part.body_zone)

	var/list/choices = list()
	for(var/i = 1, i <= spell_choices.len, i++)
		choices["[spell_choices[i].name]"] = spell_choices[i]

	var/choice = input("Choose an arcyne expression of the Lesser Work") as null|anything in choices
	var/obj/effect/proc_holder/spell/item = choices[choice]

	if (!choice || !item)
		return FALSE

	if (!(user.mob_biotypes & MOB_UNDEAD))
		user.visible_message(span_warning("The pallor of the grave descends across [user]'s skin in a wave of arcyne energy..."), span_boldwarning("A deathly chill overtakes my body at my first culmination of the Lesser Work! I feel my heart slow down in my chest..."))
		user.mob_biotypes |= MOB_UNDEAD
		to_chat(user, span_smallred("I have forsaken the living. I am now closer to a deadite than a mortal... but I still yet draw breath and bleed."))
	
	part_to_bonify.skeletonize(FALSE)
	user.update_body_parts()
	user.visible_message(span_warning("Faint runes flare beneath [user]'s skin before [user.p_their()] flesh suddenly slides away from [user.p_their()] [part_to_bonify.name]!"), span_notice("I feel arcyne power surge throughout my frail mortal form, as the Rituos takes its terrible price from my [part_to_bonify.name]."))

	if (user.mind?.rituos_spell)
		to_chat(user, span_warning("My knowledge of [user.mind.rituos_spell.name] flees..."))
		user.mind.RemoveSpell(user.mind.rituos_spell)
		user.mind.rituos_spell = null

	user.mind.has_rituos = TRUE
	
	var/post_rituos = check_ritual_progress(user)
	if (post_rituos)
		//everything but our head is skeletonized now, so grant them journeyman rank and 3 extra spellpoints to grief people with
		user.mind?.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		user.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		user.mind?.adjust_spellpoints(3)
		user.visible_message(span_boldwarning("[user]'s form swells with terrible power as they cast away almost all of the remnants of their mortal flesh, arcyne runes glowing upon their exposed bones..."), span_notice("I HAVE DONE IT! I HAVE COMPLETED HER LESSER WORK! I stand at the cusp of unspeakable power, but something is yet missing..."))
		if (prob(33))
			to_chat(user, span_small("...what have I done?"))
		return TRUE
	else
		to_chat(user, span_notice("The Lesser Work of Rituos floods my mind with stolen arcyne knowledge: I can now cast [item.name] until I next rest..."))
		user.mind.rituos_spell = item
		user.mind.AddSpell(new item)
		return TRUE
