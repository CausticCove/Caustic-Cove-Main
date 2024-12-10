/obj/item/clothing/suit/roguetown/armor/egypt
	name = "foreign dress"
	desc = "Exotic foreign dress from a faraway land. Barely covers anything."
	body_parts_covered = CHEST|GROIN
	mob_overlay_icon = 'modular_causticcove/icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "egypt"
	item_state = "egypt"
	allowed_sex = list(MALE, FEMALE)
	allowed_race = CLOTHED_RACES_TYPES
	slot_flags = ITEM_SLOT_CLOAK|ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	sewrepair = TRUE
	
/obj/item/clothing/suit/roguetown/armor/barrelarmor
	name = "barrel armor"
	desc = "It's a barrel. Being used as armor. I'm not sure what more needs to be said."
	icon = 'modular_causticcove/icons/roguetown/clothing/armor.dmi'
	mob_overlay_icon = 'modular_causticcove/icons/roguetown/clothing/onmob/armor.dmi'
	icon_state = "barrelarmor"
	item_state = "barrelarmor"
	allowed_sex = list(MALE, FEMALE)
	blocksound = SOFTHIT
	armor = list("blunt" = 50, "slash" = 70, "stab" = 30, "bullet" = 15, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_CHOP)
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	max_integrity = 300
	slot_flags = ITEM_SLOT_CLOAK
