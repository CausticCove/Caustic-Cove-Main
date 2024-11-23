/mob/living/carbon/human/proc/give_college()
	var/list/colleges = list(
		"College of Lore",
		"College of Eloquence",
		"College of Spirits",
		"College of Swords",
		"College of Whispers")

	var/collegechoice = input("Choose your college", "Available colleges") as anything in colleges
	trygivecollege(collegechoice)

/mob/living/carbon/human/proc/trygivecollege(var/T)
	switch(T)
		if("College of Lore")
			src.mind.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
			src.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

		if("College of Eloquence")
			ADD_TRAIT(src, TRAIT_NOBLE, TRAIT_GENERIC)

		if("College of Spirits")
			ADD_TRAIT(src, TRAIT_SPIRITUAL, TRAIT_GENERIC)
			ADD_TRAIT(src, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
			src.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)

		if("College of Swords")
			src.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			src.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			src.give_fightingstyle() //gives one fighting style 

		if("College of Whispers")
			src.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
			src.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)

