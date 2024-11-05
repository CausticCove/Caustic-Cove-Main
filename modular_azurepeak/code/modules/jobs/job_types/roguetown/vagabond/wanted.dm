/datum/advclass/vagabond_wanted
	name = "Wanted"
	tutorial = "The long arm of the law reaches out for you - are you slippery enough to evade its grip this time, or is your head destined to end up in an Excidium's maw?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_ALL_KINDS
	outfit = /datum/outfit/job/roguetown/vagabond/wanted
	category_tags = list(CTAG_VAGABOND)

/datum/outfit/job/roguetown/vagabond/wanted/pre_equip(mob/living/carbon/human/H)
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
	
	if (H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", -1)
		H.change_stat("fortune", rand(-2, 2))
		var/my_crime = input(H, "What is your crime?", "Crime") as text|null
		if (!my_crime)
			my_crime = "crimes against the Crown"
		var/list/bounty_cats = list("Meagre", "Moderate", "Massive")
		var/bounty_amount = input(H, "How ample is your bounty?", "Blooded Gold") as anything in bounty_cats
		var/bounty_total
		switch (bounty_amount)
			if ("Meagre")
				bounty_total = rand(15, 60)
			if ("Moderate")
				bounty_total = rand(61, 120)
			if ("Massive")
				bounty_total = rand(121, 180)
	
		add_bounty(H.real_name, bounty_total, FALSE, my_crime, "the Justiciary of Azure Peak")
		to_chat(H, span_notice("I'm on the run from the law, and there's a [lowertext(bounty_amount)] sum of mammons out on my head... better lay low."))
