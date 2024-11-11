
/datum/special_trait
	abstract_type = /datum/special_trait
	var/name
	var/greet_text
	var/req_text
	var/weight = 100
	var/list/allowed_sexes
	var/list/allowed_races
	var/list/allowed_ages
	var/list/allowed_patrons
	var/list/allowed_jobs
	var/list/allowed_migrants
	var/list/restricted_migrants
	var/list/restricted_traits
	var/list/restricted_races
	var/list/restricted_jobs

/datum/special_trait/proc/can_apply(mob/living/carbon/human/character)
	return TRUE

/datum/special_trait/proc/on_apply(mob/living/carbon/human/character, silent)
	return

/mob/living/carbon/human
	var/list/special_traits = list()

/mob/living/carbon/human/proc/add_special_trait(trait_type)
	var/datum/special_trait/special = GLOB.special_traits[trait_type]
	if(special && !(special in special_traits))
		special_traits += special
		special.on_apply(src, FALSE)

/mob/living/carbon/human/proc/remove_special_trait(trait_type)
	var/datum/special_trait/special = GLOB.special_traits[trait_type]
	if(special in special_traits)
		special_traits -= special

/mob/living/carbon/human/proc/handle_trait()
	for(var/datum/special_trait/special in special_traits)
		special.on_life(src) 

/datum/special_trait/proc/on_life()
	return

