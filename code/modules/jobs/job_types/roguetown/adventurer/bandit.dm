/datum/job/roguetown/bandit //pysdon above there's like THREE bandit.dms now I'm so sorry. This one is latejoin bandits, the one in villain is the antag datum, and the one in the 'antag' folder is an old adventurer class we don't use. Good luck!
	title = "Bandit"
	flag = BANDIT
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	antag_job = TRUE
	allowed_races = RACES_ALL_KINDS
	tutorial = "Long ago you did a crime worthy of your bounty being hung on the wall outside of the local inn. You now live with your fellow freemen in the bog, and generally get up to no good."

	outfit = null
	outfit_female = null



	display_order = JDO_BANDIT
	announce_latejoin = FALSE
	min_pq = 3
	max_pq = null

	advclass_cat_rolls = list(CTAG_BANDIT = 20)
	PQ_boost_divider = 10

	wanderer_examine = TRUE
	advjob_examine = TRUE
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = FALSE //no endless stream of bandits, unless the migration waves deem it so
	same_job_respawn_delay = 30 MINUTES
	cmode_music = 'sound/music/combat_bandit2.ogg'

/datum/job/roguetown/bandit/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(!H.mind)
			return
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
		H.ambushable = FALSE

/datum/outfit/job/roguetown/bandit/post_equip(mob/living/carbon/human/H)
	..()
	var/datum/antagonist/new_antag = new /datum/antagonist/bandit()
	H.mind.add_antag_datum(new_antag)
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "BANDIT"), 5 SECONDS)
