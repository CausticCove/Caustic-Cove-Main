/datum/advclass/musketeer
	name = "Musketeer"
	tutorial = "A merry musketman seeking to save the girl and the day!"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/musketeer
	traits_applied = list(TRAIT_DODGEEXPERT)
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/combat_duelist.ogg'


/datum/outfit/job/roguetown/adventurer/musketeer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/tricorn
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/leather/black
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/studded
	cloak = /obj/item/clothing/cloak/tabard/musketeer
	backl = /obj/item/storage/backpack/rogue/satchel/musketeer
	backr = /obj/item/gun/ballistic/arquebus
	beltr = /obj/item/rogueweapon/sword/rapier
	beltl = /obj/item/bulletpouch/bullet
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.change_stat("intelligence", 1)
	H.change_stat("speed", 2)
	H.change_stat("endurance", 1)
	H.change_stat("perception", 3)
