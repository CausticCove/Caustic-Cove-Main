/datum/advclass/rogue
	name = "Rogue"
	tutorial = "Rogues are men of shadows, and commonly associated with banditry. Most are usually akin to criminals, \
	and those who aren't are usually treated as such anyway. \
	The class has the choice between the thieving rogue, the shadowy assassin, or the more upfront duelist."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/adventurer/rogue
	traits_applied = list(TRAIT_MEDIUMARMOR, TRAIT_DODGEEXPERT)
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	var/classchoice
	H.adjust_blindness(-3)
	H.visible_message(span_info("I contributed into this world, I have been around..."))
	var/classes = list("Rogue","Assassin","Duelist","Arcane Trickster")
	classchoice = input("Choose your archetypes", "Available archetypes") as anything in classes
	switch(classchoice)
		if("Rogue")
			H.set_blindness(0)
			roguearch(H)
		if("Assassin")
			H.set_blindness(0)
			assassinarch(H)
		if("Duelist")
			H.set_blindness(0)
			duelistarch(H)
		if("Arcane Trickster")
			H.set_blindness(0)
			tricksterarch(H)

/datum/outfit/job/roguetown/adventurer/rogue/proc/roguearch(mob/living/carbon/human/H)
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 3, TRUE)
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel/parrying
	backpack_contents = list(/obj/item/lockpickring/mundane)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.change_stat("strength", -1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 3)
	H.change_stat("intelligence", 2)
	H.cmode_music = 'sound/music/combat_rogue.ogg'

/datum/outfit/job/roguetown/adventurer/rogue/proc/assassinarch(mob/living/carbon/human/H)
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/maces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 5, TRUE)
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/huntingknife/idagger/silver/elvish
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	beltr = /obj/item/ammo_holder/quiver/bolts
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES_SHITTY, TRAIT_GENERIC)
	H.change_stat("strength", -1)
	H.change_stat("perception", 2)
	H.change_stat("speed", 3)
	H.change_stat("intelligence", 2)
	H.cmode_music = 'sound/music/combat_rogue.ogg'
	to_chat(H, span_info("I honed my skills as a rogue through the years, and was skilled enough to become an assassin. Now it depends to me how I use my abilities."))
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel, /obj/item/lockpickring/mundane)

/datum/outfit/job/roguetown/adventurer/rogue/proc/duelistarch(mob/living/carbon/human/H)
	//basically like swashbuckller. 
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/tracking, 2, TRUE)
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	head = /obj/item/clothing/head/roguetown/bardhat
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	cloak = /obj/item/clothing/cloak/half
	backl = /obj/item/storage/backpack/rogue/satchel
	beltl = /obj/item/rogueweapon/sword/rapier
	beltr = /obj/item/rogueweapon/shield/buckler
	backpack_contents = list(/obj/item/rogueweapon/huntingknife/idagger/steel/parrying, /obj/item/lockpickring/mundane)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC) //extra damage to groin, dirty tricks.
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.change_stat("strength", 1)
	H.change_stat("speed", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("perception", 1)
	H.cmode_music = 'sound/music/combat_duelist.ogg'
	to_chat(H, span_info("I trained as a swashbuckler, flair and precision is my weapon... And some dirty tricks under my cape. I can fool people into underestimating me, their last mistake."))

// Arcane Trickster - A charlatan, magic using rogue (based on arcane trickster archetype from 5e)
/datum/outfit/job/roguetown/adventurer/rogue/proc/tricksterarch(mob/living/carbon/human/H)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/roguetown/leather
	if(prob(30))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/half
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/huntingknife/idagger/steel
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	backpack_contents = list(/obj/item/lockpickring/mundane)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.change_stat("strength", -2)
	H.change_stat("perception", 2)
	H.change_stat("speed", 2)
	H.change_stat("intelligence", 3)
	H.visible_message(span_info("I’m not just a thief. I'm a master of illusion and deception. One moment, I'm a harmless vagabond. The next, I'm a blur of motion, leaving my pursuers bewildered and outwitted."))
	if(H.mind)
		H.mind.adjust_spellpoints(1)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
