/obj/effect/proc_holder/spell/targeted/touch/Nocdarkvision
	name = "Darkvision"
	overlay_state = "thaumaturgy"
	desc = "Enhance the night vision of a target you touch for 15 minutes."
	clothes_req = FALSE
	drawmessage = "I prepare to grant Darkvision."
	dropmessage = "I return my mind to the now."
	school = "transmutation"
	charge_max = 1 MINUTES
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/holy
	hand_path = /obj/item/melee/touch_attack/Nocdarkvision
	xp_gain = TRUE
	devotion_cost = 20

/obj/item/melee/touch_attack/Nocdarkvision
	name = "\improper arcyne focus"
	desc = "Touch a creature to grant them Darkvision for 15 minutes."
	catchphrase = null
	possible_item_intents = list(INTENT_HELP)
	icon = 'icons/mob/roguehudgrabs.dmi'
	icon_state = "pulling"
	icon_state = "grabbing_greyscale"
	color = "#3FBAFD"

/obj/item/melee/touch_attack/Nocdarkvision/attack_self()
	attached_spell.remove_hand()

/obj/item/melee/touch_attack/Nocdarkvision/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(isliving(target))
		var/mob/living/spelltarget = target
		if(!do_after(user, 5 SECONDS, target = spelltarget))
			return
		spelltarget.apply_status_effect(/datum/status_effect/buff/darkvision)
		user.rogfat_add(80)
		if(spelltarget != user)
			user.visible_message("[user] draws a glyph in the air and touches [spelltarget], their eyes briefly flashing with Noc's light.")
		else
			user.visible_message("[user] draws a glyph in the air and touches themselves, their eyes briefly flashing with Noc's light.")
		attached_spell.remove_hand()
	return
