
/obj/item/roguestatue
	icon = 'icons/roguetown/items/valuable.dmi'
	name = "statue"
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null

/obj/item/roguestatue/gold
	name = "gold statue"
	desc = "Made of heavy, gleaming gold!"
	icon_state = "gstatue1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 120

/obj/item/roguestatue/gold/Initialize()
	. = ..()
	icon_state = "gstatue[pick(1,2)]"

/obj/item/roguestatue/gold/loot
	name = "gold statuette"
	desc = "Made of heavy, gleaming gold!"
	icon_state = "lstatue1"
	sellprice = 45

/obj/item/roguestatue/gold/loot/Initialize()
	. = ..()
	sellprice = rand(45,150)
	icon_state = "lstatue[pick(1,2,3,4)]"

/obj/item/roguestatue/silver
	name = "silver statue"
	desc = "Made of pure, shimmering silver!"
	icon_state = "sstatue1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 90

/obj/item/roguestatue/silver/Initialize()
	. = ..()
	icon_state = "sstatue[pick(1,2)]"

/obj/item/roguestatue/steel
	name = "steel statue"
	desc = "An unyielding statue of resilient steel."
	icon_state = "ststatue1"
	smeltresult = /obj/item/ingot/steel
	sellprice = 60

/obj/item/roguestatue/steel/Initialize()
	. = ..()
	icon_state = "ststatue[pick(1,2)]"

/obj/item/roguestatue/iron
	name = "iron statue"
	desc = "A forged statue of cast iron!"
	icon_state = "istatue1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 40

/obj/item/roguestatue/iron/Initialize()
	. = ..()
	icon_state = "istatue[pick(1,2)]"


//000000000000000000000000000--

/obj/item/var/polished = FALSE

/obj/item/examine(mob/user)
	. = ..()
	switch(polished)
		if(1)
			. += span_info("It has some polishing compound on it.")
		if(2, 3)
			. += span_info("It's been thoroughly brushed.")
		if(4)
			. += span_green("It's been nicely polished.")

/obj/item/polishing_cream
	icon = 'icons/roguetown/items/misc.dmi'
	name = "polishing cream"
	desc = "A pure silver compound made for making the best metals shine."
	icon_state = "cream"
	w_class = WEIGHT_CLASS_SMALL
	dropshrink = 0.8
	var/uses = 12

/obj/item/polishing_cream/examine(mob/user)
	. = ..()
	. += span_info("It has [uses] uses left.")

/obj/item/polishing_cream/attack_obj(obj/O, mob/living/user)
	if(!isitem(O) || !uses)
		return ..()
	var/obj/item/thing = O
	if(!thing.anvilrepair)
		return ..()
	if((HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR) || user.mind.get_skill_level(thing.anvilrepair)) && thing.polished == 0 && obj_integrity <= max_integrity)
		to_chat(user, span_info("I start applying some compound to \the [thing]..."))
		if(do_after(user, 50 - user.STASPD*2, target = O))
			thing.polished = 1
			uses--
			thing.remove_atom_colour(FIXED_COLOUR_PRIORITY)
			thing.add_atom_colour("#635e65", FIXED_COLOUR_PRIORITY)
			thing.RegisterSignal(thing, COMSIG_COMPONENT_CLEAN_ACT, PROC_REF(remove_polish))
			if(uses <= 8)
				smeltresult = null
				icon_state = "low_cream"
			if(!uses)
				icon_state = "empty_cream"

/obj/item/armor_brush
	icon = 'icons/roguetown/items/misc.dmi'
	name = "fine brush"
	desc = "A coarse brush for scrubbing armor thoroughly. Made of the finest Lupin hair."
	icon_state = "brush_0"
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = null
	dropshrink = 0.8
	var/roughness = 0 // 0  for a fine brush, 1 for a coarse brush

/obj/item/armor_brush/attack_self(mob/user)
	roughness = 1 - roughness
	if(roughness)
		to_chat(user, span_info("I flip the brush to the coarse side."))
		name = "coarse brush"
	else
		to_chat(user, span_info("I flip the brush to the fine side."))
		name = "fine brush"
	icon_state = "brush_[roughness]"

/obj/item/armor_brush/attack_obj(obj/O, mob/living/user)
	if(!isitem(O))
		return ..()
	var/obj/item/thing = O
	if(thing.polished == 1 && roughness)
		if((HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR) || user.mind.get_skill_level(thing.anvilrepair)))
			to_chat(user, span_info("I start roughly scrubbing the compound on \the [thing]..."))
			playsound(loc,"sound/foley/scrubbing[pick(1,2)].ogg", 100, TRUE)
			if(do_after(user, 50 - user.STASTR*1.5, target = O))
				thing.polished = 2
				thing.remove_atom_colour(FIXED_COLOUR_PRIORITY)
				thing.add_atom_colour("#9e9e9e", FIXED_COLOUR_PRIORITY)

	else if(thing.polished == 2 && !roughness)
		if((HAS_TRAIT(user, TRAIT_SQUIRE_REPAIR) || user.mind.get_skill_level(thing.anvilrepair)))
			to_chat(user, span_info("I start gently scrubbing the edges of \the [thing]..."))
			playsound(loc,"sound/foley/scrubbing[pick(1,2)].ogg", 100, TRUE)
			if(do_after(user, 50 - user.STASTR*1.5, target = O))
				thing.polished = 3
				thing.remove_atom_colour(FIXED_COLOUR_PRIORITY)
				thing.add_atom_colour("#cccccc", FIXED_COLOUR_PRIORITY)

/obj/item/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armor_penetration)
	. = ..()
	if(src)
		if(polished == 4)
			polished = 0
			force -= 2
			force_wielded -= 3
			var/datum/component/glint = GetComponent(/datum/component/metal_glint)
			qdel(glint)
		else if(polished >= 1 && polished <= 4)
			remove_atom_colour(FIXED_COLOUR_PRIORITY)
			UnregisterSignal(src, COMSIG_COMPONENT_CLEAN_ACT)

/obj/item/proc/remove_polish(datum/source, strength) // kill polska
	if(polished == 3 && obj_integrity >= max_integrity)
		polished = 4
		remove_atom_colour(FIXED_COLOUR_PRIORITY)
		add_atom_colour("#ffffff", FIXED_COLOUR_PRIORITY)
		obj_integrity += 50
		force += 2
		force_wielded += 3
		AddComponent(/datum/component/metal_glint)
		UnregisterSignal(src, COMSIG_COMPONENT_CLEAN_ACT)

	else if(polished < 4)
		polished = 0
		remove_atom_colour(FIXED_COLOUR_PRIORITY)
		UnregisterSignal(src, COMSIG_COMPONENT_CLEAN_ACT)

/obj/effect/temp_visual/armor_glint
	name = "glint"
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = "glint"
	alpha = 200
	duration = 13
	plane = -1

/obj/effect/temp_visual/armor_glint/Initialize(mapload, var/extra_rand = 1)
	. = ..()
	pixel_x = extra_rand * rand(-5,5)
	pixel_y = extra_rand * rand(-5,5)
	animate(src, alpha = 0, time = duration)

/datum/component/metal_glint/Initialize()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, list(COMSIG_PARENT_QDELETING), PROC_REF(stop_process))
	START_PROCESSING(SSobj, src)

/datum/component/metal_glint/process()
	var/atom/current_parent = parent
	if(istype(current_parent.loc,/turf) || istype(current_parent.loc, /mob/living))
		if(prob(25))
			new /obj/effect/temp_visual/armor_glint(current_parent.loc)
		if(prob(15))
			new /obj/effect/temp_visual/armor_glint(current_parent.loc, 2)
		if(prob(5))
			new /obj/effect/temp_visual/armor_glint(current_parent.loc, 3)

/datum/component/metal_glint/proc/stop_process()
	STOP_PROCESSING(SSobj, src)
