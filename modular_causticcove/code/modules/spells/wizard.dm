/obj/effect/proc_holder/spell/targeted/touch/sizespell
	name = "Reduce/Grow Person"
	desc = "A basic trick many apprentices would use to prank their master."
	clothes_req = FALSE
	drawmessage = "I prepare to perform a arcyne incantation."
	dropmessage = "I release my arcyne focus."
	school = "transmutation"
	overlay_state = "size-change"
	castdrain = 50
	chargetime = 10
	charge_max = 2 MINUTES
	cost = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	hand_path = /obj/item/melee/touch_attack/sizespell

/obj/item/melee/touch_attack/sizespell
	name = "\improper magic touch"
	desc = "You recall the following incantations you've learned:\n \
	<b>Reduce</b>: Will Shrink whoever you touch.\n \
	<b>Grow</b>: Will grow whoever you touch, you may also touch yourself. (huehue, get it?)"
	catchphrase = null
	possible_item_intents = list(INTENT_HELP, INTENT_DISARM)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#ff0000" // this produces green because the icon base is yellow but someone else can fix that if they want
	

/obj/item/melee/touch_attack/sizespell/attack_self()
	qdel(src)

/obj/item/melee/touch_attack/sizespell/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(!proximity)
		return

	switch (user.used_intent.type)
		if(INTENT_HELP) //Reduce
			shrink_target(target, user)
		if(INTENT_DISARM) //Grow
			grow_target(target, user)

/obj/item/melee/touch_attack/sizespell/proc/shrink_target(mob/living/target, mob/living/carbon/human/user)
	if(!isliving(target))
		return

	if(user == target)
		user.visible_message(span_notice("[user] rapidly changes in size!"), span_notice("I rapidly shrink down!"))
	else	
		user.visible_message(span_notice("[user] touch [target], and they changes in size!"), span_notice("I touch [target] and they shrink in size!"))
	target.apply_status_effect(/datum/status_effect/buff/shrinked)
	qdel(src)


/obj/item/melee/touch_attack/sizespell/proc/grow_target(mob/living/target, mob/living/carbon/human/user)
	if(!isliving(target))
		return

	if(user == target)
		user.visible_message(span_notice("[user] rapidly changes in size!"), span_notice("I rapidly grow up!"))
	else	
		user.visible_message(span_notice("[user] touch [target], and they changes in size!"), span_notice("I touch [target] and they grow in size!"))
	target.apply_status_effect(/datum/status_effect/buff/growth)
	qdel(src)

/datum/status_effect/buff/shrinked
	id = "shrink"
	alert_type = /atom/movable/screen/alert/status_effect/buff/shrinked
	effectedstats = list("speed" = 3, "strength" = -6, "fortune" = -3)
	var/removable = FALSE

/datum/status_effect/buff/shrinked/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.transform = target.transform.Scale(0.5, 0.5)
	target.update_transform()
	target.pass_flags = PASSTABLE | PASSMOB
	spawn(300) //is that how it work? i remember there being a better wait timer but i forgor
		if(owner && istype(owner, /mob/living))
			to_chat(owner, span_userdanger("<span class='big'>You feel like you might be able to return to your size by pressing on the status effect!</span>"))
			removable = TRUE

/datum/status_effect/buff/shrinked/on_remove()
	var/mob/living/target = owner
	target.transform = target.transform.Scale(2, 2)
	target.update_transform()
	target.pass_flags = 0
	. = ..()

/atom/movable/screen/alert/status_effect/buff/shrinked
	name = "Shrinked"
	desc = "I've been shrinked! (After 30 seconds, you can press this button to return to your original size.)"
	icon_state = "debuff"
	/datum/status_effect/buff/shrinked

/atom/movable/screen/alert/status_effect/buff/shrinked/Click()
	. = ..()
	var/mob/living/L = usr
	if(!istype(L)) // how though
		return
	var/datum/status_effect/buff/shrinked/effect = L.has_status_effect(/datum/status_effect/buff/shrinked)
	if(!effect.removable)
		to_chat(L, span_userdanger("<span class='warning'>I can't turn back yet!</span>"))
		return
	L.remove_status_effect(/datum/status_effect/buff/shrinked)


/datum/status_effect/buff/growth
	id = "growth"
	alert_type = /atom/movable/screen/alert/status_effect/buff/growth
	effectedstats = list("speed" = -6, "strength" = 3)
	var/removable = FALSE

/datum/status_effect/buff/growth/on_apply()
	. = ..()
	var/mob/living/target = owner
	target.transform = target.transform.Scale(2, 2)
	target.transform = target.transform.Translate(0, (1 * 16))
	target.update_transform()
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)
	spawn(300) //is that how it work? i remember there being a better wait timer but i forgor, so i'm using this one
		if(owner && istype(owner, /mob/living))
			to_chat(owner, span_userdanger("<span class='big'>You feel like you might be able to return to your size now by pressing on the status effect!</span>"))
			removable = TRUE

/datum/status_effect/buff/growth/on_remove()
	var/mob/living/target = owner
	target.transform = target.transform.Scale(0.5, 0.5)
	target.transform = target.transform.Translate(0, -(1 * 16))
	target.update_transform()
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)
	. = ..()

/atom/movable/screen/alert/status_effect/buff/growth
	name = "Growth"
	desc = "I've became bigger! (After 30 seconds, you can press this button to return to your original size.)"
	icon_state = "debuff"
	/datum/status_effect/buff/growth

/atom/movable/screen/alert/status_effect/buff/growth/Click()
	. = ..()
	var/mob/living/L = usr
	if(!istype(L)) // how though
		return
	var/datum/status_effect/buff/growth/effect = L.has_status_effect(/datum/status_effect/buff/growth)
	if(!effect.removable)
		to_chat(L, span_userdanger("<span class='warning'>I can't turn back yet!</span>"))
		return
	L.remove_status_effect(/datum/status_effect/buff/growth)
