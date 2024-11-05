/datum/advclass/vagabond_mage
	name = "Exiled Apprentice"
	tutorial = "Your master found you talentless, and cast you from their tower with nothing but your staff and dreams of what could've been."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/vagabond/mage
	category_tags = list(CTAG_VAGABOND)

/datum/outfit/job/roguetown/vagabond/mage/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/rags
	else
		pants = /obj/item/clothing/under/roguetown/tights/vagrant
		if(prob(50))
			pants = /obj/item/clothing/under/roguetown/tights/vagrant/l
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant
		if(prob(50))
			shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/vagrant/l

	if(prob(33))
		cloak = /obj/item/clothing/cloak/half/brown
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	
	r_hand = /obj/item/rogueweapon/woodstaff

	if (H.mind)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
		H.mind.adjust_spellpoints(1)
		H.change_stat("intelligence", 2)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)
