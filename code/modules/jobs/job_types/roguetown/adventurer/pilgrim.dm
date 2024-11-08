/datum/job/roguetown/pilgrim
	title = "Pilgrim"
	flag = PILGRIM
	department_flag = PEASANTS
	faction = "Station"
	total_positions = -1
	spawn_positions = -1
	allowed_races = RACES_ALL_KINDS
	tutorial = "Fleeing misfortune you head your way towards Azure Peak, you're not a soldier or an explorer, but a humble migrant trying to look for a better life, if you get to survive the trip that is."

	outfit = null
	outfit_female = null
	bypass_lastclass = TRUE
	bypass_jobban = FALSE

	advclass_cat_rolls = list(CTAG_PILGRIM = 20)
	PQ_boost_divider = 10

	announce_latejoin = FALSE
	display_order = JDO_PILGRIM
	min_pq = -20
	max_pq = null
	round_contrib_points = 2
	wanderer_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	same_job_respawn_delay = 0

/datum/job/roguetown/pilgrim/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(H.dna?.species)
		if(isanthrom(H))
			H.change_stat("strength", 8)
			H.change_stat("constitution", 8)
			H.change_stat("endurance", 8)
			H.change_stat("speed", -8)
			H.change_stat("speed", -4)
			H.transform = H.transform.Scale(2.25, 2.25)
			H.transform = H.transform.Translate(0, (0.25 * 16))
			H.update_transform()
		if(isdemim(H))
			H.change_stat("strength", 8)
			H.change_stat("constitution", 8)
			H.change_stat("endurance", 8)
			H.change_stat("speed", -8)
			H.change_stat("speed", -4)
			H.transform = H.transform.Scale(2.25, 2.25)
			H.transform = H.transform.Translate(0, (0.25 * 16))
			H.update_transform()

		if(GLOB.adventurer_hugbox_duration)
			///FOR SOME SILLY FUCKING REASON THIS REFUSED TO WORK WITHOUT A FUCKING TIMER IT JUST FUCKED SHIT UP
			addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_start)), 1)
