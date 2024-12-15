/datum/anvil_recipe/engineering
	i_type = "Engineering"
	appro_skill = /datum/skill/craft/engineering
	craftdiff = 1

	//GUN AMMO

/datum/anvil_recipe/engineering/iron/leadball
	name = "Iron Balls (3x)"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/ammo_casing/caseless/lead
	createditem_num = 3
	i_type = "Ammo"

/datum/anvil_recipe/engineering/iron/runeball
	name = "Runic Ball"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/ammo_casing/caseless/runelock
	i_type = "Ammo"
