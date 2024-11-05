/datum/advclass/vagabond_excommunicated
	name = "Excommunicated"
	tutorial = "The Church has found you bereft of mercy, and you walk the lands of Azure with nothing but the tattered shreds of the faith you cling to."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/vagabond/excommunicated
	category_tags = list(CTAG_VAGABOND)

/datum/outfit/job/roguetown/vagabond/excommunicated/pre_equip(mob/living/carbon/human/H)
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
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)

		var/datum/devotion/C = new /datum/devotion(H, H.patron)
		C.grant_spells(H)
		H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
		GLOB.excommunicated_players += H.real_name // john roguetown, you are EXCOMMUNICADO.
