/datum/job/roguetown/farmer
	title = "Soilson"
	flag = FARMER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 3
	spawn_positions = 5
	display_order = JDO_SOILSON
	selection_color = JCOLOR_PEASANT
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS

	tutorial = "It is a simple life you live, your basic understanding of life is something many would be envious of if they knew just how perfect it was. You know a good day's work, the sweat on your brow is yours: Famines and plague may take their toll, but you know how to celebrate life well. Till the soil and produce fresh food for those around you, and maybe you'll be more than an unsung hero someday."


	f_title = "Soilbride"
	outfit = /datum/outfit/job/roguetown/farmer
	display_order = 24
	give_bank_account = 17
	min_pq = -10
	max_pq = null
	round_contrib_points = 3

/datum/outfit/job/roguetown/farmer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/farming, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/butchering, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)
		ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

	if(H.pronouns == SHE_HER || H.pronouns == THEY_THEM_F)
		head = /obj/item/clothing/head/roguetown/armingcap
//		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/roguekey/farm
	else
		head = /obj/item/clothing/head/roguetown/roguehood/random
		if(prob(50))
			head = /obj/item/clothing/head/roguetown/strawhat
		pants = /obj/item/clothing/under/roguetown/tights/random
		armor = /obj/item/clothing/suit/roguetown/armor/workervest
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/roguekey/farm
