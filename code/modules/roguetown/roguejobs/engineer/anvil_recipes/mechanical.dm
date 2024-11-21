/datum/anvil_recipe/engineering
	i_type = "Engineering"
	appro_skill = /datum/skill/craft/engineering
	craftdiff = 1

// --------- BRONZE RECIPES -----------

/datum/anvil_recipe/engineering/bronze/locks
	name = "Lock"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/customlock
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/keys
	name = "Keys 2x"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/customblank
	createditem_num = 2
	craftdiff = 1

/datum/anvil_recipe/engineering/bronze/cog
	name = "Cog"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/roguegear
	craftdiff = 0

/datum/anvil_recipe/engineering/bronze/lamptern
	name = "Bronze Lamptern"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/flashlight/flare/torch/lantern/bronzelamptern
	craftdiff = 3

// ------------ PROSTHETICS ----------------

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzeleft
	name = "Bronze Left Arm"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/l_arm/prosthetic/bronzeleft
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/prosthetic/bronzeright
	name = "Bronze Right Arm"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/ingot/bronze, /obj/item/roguegear, /obj/item/roguegear)
	created_item = /obj/item/bodypart/r_arm/prosthetic/bronzeright
	craftdiff = 4

//------------- FIREARMS AND AMMO -------------------

/datum/anvil_recipe/engineering/bronze/guns/pistol
	name = "Arquebus Pistol"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/grown/log/tree/small)
	created_item = /obj/item/gun/ballistic/arquebus_pistol
	craftdiff = 4

/datum/anvil_recipe/engineering/bronze/guns/arquebus
	name = "Arquebus Gun "
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/ingot/bronze, /obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/gun/ballistic/arquebus
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/guns/handgonne
	name = "Handgonne"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/ingot/bronze, /obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/gun/ballistic/arquebus
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/guns/runelockgem
	name = "Runelock (Gemerald)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/grown/log/tree/small, /obj/item/roguegem/green)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/guns/runelockront
	name = "Runelock (Rontz)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/grown/log/tree/small, /obj/item/roguegem)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/guns/runelocktoper
	name = "Runelock (Toper)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/grown/log/tree/small, /obj/item/roguegem/yellow)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/guns/runelockblortz
	name = "Runelock (Blortz)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/grown/log/tree/small, /obj/item/roguegem/blue)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/guns/runelocksaffi
	name = "Runelock (Saffira)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/grown/log/tree/small, /obj/item/roguegem/violet)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	craftdiff = 5

/datum/anvil_recipe/engineering/bronze/guns/runelockdorp
	name = "Runelock (Dorpel)"
	req_bar = /obj/item/ingot/bronze
	additional_items = list(/obj/item/roguegear, /obj/item/grown/log/tree/small, /obj/item/roguegem/diamond)
	created_item = /obj/item/gun/ballistic/revolver/grenadelauncher/runelock
	craftdiff = 5
