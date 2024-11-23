GLOBAL_LIST_INIT(moldable_organs, list(BODY_ZONE_PRECISE_GROIN=list(ORGAN_SLOT_PENIS, ORGAN_SLOT_VAGINA, ORGAN_SLOT_TESTICLES, ORGAN_SLOT_BUTT),
	BODY_ZONE_CHEST=list(ORGAN_SLOT_BREASTS, ORGAN_SLOT_BELLY))) //Vrell - If we want to do this to other organs down the line, we can just add their slots here.

/datum/surgery/organ_manipulation
	name = "Organ manipulation"
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_PRECISE_SKULL, BODY_ZONE_CHEST)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/cauterize,
	)

/datum/surgery/organ_manipulation/soft
	possible_locs = list(
		BODY_ZONE_PRECISE_R_EYE,
		BODY_ZONE_PRECISE_L_EYE,
		BODY_ZONE_PRECISE_MOUTH,
		BODY_ZONE_PRECISE_STOMACH,
		BODY_ZONE_PRECISE_GROIN,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
	)
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract,
		/datum/surgery_step/clamp,
		/datum/surgery_step/incise,
		/datum/surgery_step/manipulate_organs,
		/datum/surgery_step/cauterize
	)

/datum/surgery_step/manipulate_organs
	name = "Manipulate organs"
	time = 6.4 SECONDS
	accept_hand = TRUE
	implements = list(
		/obj/item/organ = 80,
		/obj/item/organ_storage = 80,
		/obj/item/reagent_containers/food/snacks/organ = 0,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_INCISED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_JOURNEYMAN
	skill_median = SKILL_LEVEL_EXPERT
	preop_sound = 'sound/surgery/organ2.ogg'
	success_sound = 'sound/surgery/organ1.ogg'
	/// Implements used to extract an organ - This really should be split into two different steps...
	var/list/implements_extract = list(
		TOOL_HEMOSTAT = 80,
		TOOL_CROWBAR = 65,
		TOOL_HAND = 60,
	)

/datum/surgery_step/manipulate_organs/New()
	. = ..()
	implements = implements_extract + implements

/datum/surgery_step/manipulate_organs/validate_bodypart(mob/user, mob/living/carbon/target, obj/item/bodypart/bodypart, target_zone)
	var/static/list/hard_zones = list(
		BODY_ZONE_PRECISE_SKULL,
		BODY_ZONE_CHEST,
	)
	if(target_zone in hard_zones)
		surgery_flags |= SURGERY_BROKEN
	else
		surgery_flags &= ~SURGERY_BROKEN
	return ..()

/datum/surgery_step/manipulate_organs/try_op(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, try_to_fail)
	// stupid workaround right now because eyes are a single organ in a single slot
	if(target_zone == BODY_ZONE_PRECISE_L_EYE)
		target_zone = BODY_ZONE_PRECISE_R_EYE
	return ..()

/datum/surgery_step/manipulate_organs/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(istype(tool, /obj/item/reagent_containers/food/snacks/organ))
		to_chat(user, span_warning("[tool] was bitten by someone! It's too damaged to use!"))
		return FALSE

	if(istype(tool, /obj/item/organ_storage))
		if(!length(tool.contents))
			to_chat(user, span_warning("There is nothing inside [tool]!"))
			return FALSE
		tool = tool.contents[1]
		if(!isorgan(tool))
			to_chat(user, span_warning("I cannot put [tool] inside [target]'s [parse_zone(target_zone)]!"))
			return FALSE

	var/obj/item/organ/organ_tool = tool
	if(istype(organ_tool))
		if(target_zone != organ_tool.zone)
			to_chat(user, span_warning("[organ_tool] does not belong in [target]'s [parse_zone(target_zone)]!"))
			return FALSE
		else if(target.getorganslot(organ_tool.slot))
			to_chat(user, span_warning("[target] already has [parse_organ_slot(organ_tool.slot)]!"))
			return FALSE

		user.select_organ_slot(organ_tool.slot)
		display_results(user, target, span_notice("I begin to insert [tool] into [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins to insert [tool] into [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to insert something into [target]'s [parse_zone(target_zone)]."))
	else
		var/list/organs = target.getorganszone(target_zone, subzones = FALSE)
		if(!length(organs))
			to_chat(user, span_warning("There are no removable organs in [target]'s [parse_zone(target_zone)]!"))
			return FALSE
		for(var/obj/item/organ/found_organ as anything in organs)
			found_organ.on_find(user)
			organs -= found_organ
			organs[found_organ.name] = found_organ

		var/selected = input(user, "Remove which organ?", "PESTRA") as null|anything in sortList(organs)
		if(QDELETED(user) || QDELETED(target) || !user.Adjacent(target) || (user.get_active_held_item() != tool))
			return FALSE
		var/obj/item/organ/final_organ = organs[selected]
		if(QDELETED(final_organ))
			return FALSE

		user.select_organ_slot(final_organ.slot)
		display_results(user, target, span_notice("I begin to extract [final_organ] from [target]'s [parse_zone(target_zone)]..."),
			span_notice("[user] begins to extract [final_organ] from [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] begins to extract something from [target]'s [parse_zone(target_zone)]."))

	return TRUE

/datum/surgery_step/manipulate_organs/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(istype(tool, /obj/item/organ_storage))
		tool.icon_state = initial(tool.icon_state)
		tool.desc = initial(tool.desc)
		tool.cut_overlays()
		tool = tool.contents[1]
		if(!isorgan(tool))
			return FALSE

	var/obj/item/organ/organ_tool = tool
	if(istype(organ_tool) && user.temporarilyRemoveItemFromInventory(organ_tool))
		organ_tool.Insert(target)
		display_results(user, target, span_notice("I insert [tool] into [target]'s [parse_zone(target_zone)]."),
			span_notice("[user] inserts [tool] into [target]'s [parse_zone(target_zone)]!"),
			span_notice("[user] inserts something into [target]'s [parse_zone(target_zone)]!"))
		return TRUE
	var/obj/item/organ/selected_organ = target.getorganslot(user.organ_slot_selected)
	if(QDELETED(selected_organ) || (selected_organ.owner != target))
		display_results(user, target, span_warning("I can't extract anything from [target]'s [parse_zone(target_zone)]!"),
			span_notice("[user] can't seem to extract anything from [target]'s [parse_zone(target_zone)]!"),
			span_notice("[user] can't seem to extract anything from [target]'s [parse_zone(target_zone)]!"))
		return FALSE
	display_results(user, target, span_notice("I successfully extract [selected_organ] from [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] successfully extracts [selected_organ] from [target]'s [parse_zone(target_zone)]!"),
		span_notice("[user] successfully extracts something from [target]'s [parse_zone(target_zone)]!"))
	log_combat(user, target, "surgically removed [selected_organ.name] from")
	selected_organ.Remove(target)
	selected_organ.forceMove(target.drop_location())
	user.put_in_hands(selected_organ)
	return TRUE

/datum/surgery_step/make_organs
	name = "Mold organs"
	time = 6.4 SECONDS
	accept_hand = TRUE
	implements = list(
		TOOL_HEMOSTAT = 80,
		TOOL_CROWBAR = 65,
		TOOL_IMPROVISED_HEMOSTAT = 40,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	surgery_flags = SURGERY_INCISED | SURGERY_RETRACTED
	skill_min = SKILL_LEVEL_JOURNEYMAN
	skill_median = SKILL_LEVEL_EXPERT

/datum/surgery_step/make_organs/validate_bodypart(mob/user, mob/living/carbon/target, obj/item/bodypart/bodypart, target_zone)
	var/static/list/hard_zones = list(
		BODY_ZONE_PRECISE_SKULL,
		BODY_ZONE_CHEST,
	)
	if(target_zone in hard_zones)
		surgery_flags |= SURGERY_BROKEN
	else
		surgery_flags &= ~SURGERY_BROKEN
	return ..()

/datum/surgery_step/make_organs/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(!iscarbon(target))
		to_chat(user, span_warning("There are no organs you can mold in [target]!"))
		return FALSE
	var/mob/living/carbon/carbonize = target
	var/list/organs = GLOB.moldable_organs[target_zone]
	for(var/organslot as anything in organs)
		if(carbonize.getorganslot(organslot))
			organs -= organslot
			continue
		if(!carbonize.dna.organ_dna[organslot])
			organs -= organslot
			continue
	if(!length(organs))
		to_chat(user, span_warning("There are no organs you can mold in [target]'s [parse_zone(target_zone)]!"))
		return FALSE
	var/selected = input(user, "Create which organ?", "PESTRA") as null|anything in sortList(organs)
	if(QDELETED(user) || QDELETED(target) || !user.Adjacent(target) || (user.get_active_held_item() != tool))
		return FALSE
	if(target.getorganslot(selected))
		to_chat(user, span_warning("[target] alread has that organ!"))
		return FALSE
	user.select_organ_slot(selected)
	display_results(user, target, span_notice("I begin to mold [parse_organ_slot(selected)] in [target]'s [parse_zone(target_zone)]..."),
		span_notice("[user] begins to mold [parse_organ_slot(selected)] in [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] begins to mold something in [target]'s' [parse_zone(target_zone)]."))
	return TRUE

/datum/surgery_step/make_organs/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(!isnull(target.getorganslot(user.organ_slot_selected)))
		to_chat(user, span_warning("[target] alread has that organ!"))
		return FALSE
	display_results(user, target, span_notice("I successfully mold [parse_organ_slot(user.organ_slot_selected)] in [target]'s [parse_zone(target_zone)]."),
		span_notice("[user] successfully molds [parse_organ_slot(user.organ_slot_selected)] in [target]'s [parse_zone(target_zone)]!"),
		span_notice("[user] successfully molds something in [target]'s [parse_zone(target_zone)]!"))
	log_combat(user, target, "surgically made [parse_organ_slot(user.organ_slot_selected)] from")
	var/mob/living/carbon/carbonized = target
	var/datum/organ_dna/organ_template = carbonized.dna.organ_dna[user.organ_slot_selected]
	var/obj/item/organ/organ_to_add = organ_template.create_organ(target)
	organ_to_add.Insert(target)
	return TRUE
