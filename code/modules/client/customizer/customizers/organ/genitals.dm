/datum/customizer/organ/penis
	abstract_type = /datum/customizer/organ/penis
	name = "Penis"
	allows_disabling = TRUE
	default_disabled = TRUE
	gender_enabled = MALE

/datum/customizer/organ/penis/is_allowed(datum/preferences/prefs)
	return TRUE

/datum/customizer_choice/organ/penis
	abstract_type = /datum/customizer_choice/organ/penis
	name = "Penis"
	organ_type = /obj/item/organ/penis
	organ_slot = ORGAN_SLOT_PENIS
	organ_dna_type = /datum/organ_dna/penis
	customizer_entry_type = /datum/customizer_entry/organ/penis

/datum/customizer_choice/organ/penis/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	penis_entry.penis_size = sanitize_integer(penis_entry.penis_size, MIN_PENIS_SIZE, MAX_PENIS_SIZE, DEFAULT_PENIS_SIZE)

/datum/customizer_choice/organ/penis/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/penis/penis_dna = organ_dna
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	penis_dna.penis_size = penis_entry.penis_size

/datum/customizer_choice/organ/penis/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	dat += "<br>Penis size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=penis_size''>[find_key_by_value(GLOB.named_penis_sizes, penis_entry.penis_size)]</a>"

/datum/customizer_choice/organ/penis/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/penis/penis_entry = entry
	switch(href_list["customizer_task"])
		if("penis_size")
			var/named_size = input(user, "Choose your penis size:", "Character Preference", find_key_by_value(GLOB.named_penis_sizes, penis_entry.penis_size)) as anything in GLOB.named_penis_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_penis_sizes[named_size]
			penis_entry.penis_size = sanitize_integer(new_size, MIN_PENIS_SIZE, MAX_PENIS_SIZE, DEFAULT_PENIS_SIZE)

/datum/customizer_entry/organ/penis
	var/penis_size = DEFAULT_PENIS_SIZE

/datum/customizer/organ/penis/human
	customizer_choices = list(/datum/customizer_choice/organ/penis/human)

/datum/customizer/organ/penis/anthro
	customizer_choices = list(
		/datum/customizer_choice/organ/penis/human_anthro,
		/datum/customizer_choice/organ/penis/knotted,
		/datum/customizer_choice/organ/penis/equine,
		/datum/customizer_choice/organ/penis/tapered_mammal,
		/datum/customizer_choice/organ/penis/tapered,
		/datum/customizer_choice/organ/penis/tapered_double,
		/datum/customizer_choice/organ/penis/tapered_double_knot,
		/datum/customizer_choice/organ/penis/barbed,
		/datum/customizer_choice/organ/penis/barbed_knotted,
		/datum/customizer_choice/organ/penis/tentacle,
		)

/datum/customizer/organ/penis/canine
	customizer_choices = list(
		/datum/customizer_choice/organ/penis/human_anthro,
		/datum/customizer_choice/organ/penis/knotted,
		)

/datum/customizer/organ/penis/feline
	customizer_choices = list(
		/datum/customizer_choice/organ/penis/human_anthro,
		/datum/customizer_choice/organ/penis/barbed,
		/datum/customizer_choice/organ/penis/barbed_knotted,
		)

/datum/customizer/organ/penis/lizard
	customizer_choices = list(
		/datum/customizer_choice/organ/penis/human_anthro,
		/datum/customizer_choice/organ/penis/tapered,
		/datum/customizer_choice/organ/penis/tapered_double,
		/datum/customizer_choice/organ/penis/tapered_double_knot,
		)

/datum/customizer/organ/penis/equine
	customizer_choices = list(
		/datum/customizer_choice/organ/penis/human_anthro,
		/datum/customizer_choice/organ/penis/equine,
		)

/datum/customizer_choice/organ/penis/human
	name = "Plain Penis"
	organ_type = /obj/item/organ/penis
	sprite_accessories = list(/datum/sprite_accessory/penis/human)
	allows_accessory_color_customization = FALSE

/datum/customizer_choice/organ/penis/human_anthro
	name = "Plain Penis"
	organ_type = /obj/item/organ/penis
	sprite_accessories = list(/datum/sprite_accessory/penis/human)
	allows_accessory_color_customization = TRUE

/datum/customizer_choice/organ/penis/knotted
	name = "Knotted Penis"
	organ_type = /obj/item/organ/penis/knotted
	sprite_accessories = list(
		/datum/sprite_accessory/penis/knotted,
		/datum/sprite_accessory/penis/knotted2,
		)

/datum/customizer_choice/organ/penis/equine
	name = "Equine Penis"
	organ_type = /obj/item/organ/penis/equine
	sprite_accessories = list(
		/datum/sprite_accessory/penis/flared,
		)

/datum/customizer_choice/organ/penis/tapered_mammal
	name = "Tapered Penis (Mammal)"
	organ_type = /obj/item/organ/penis/tapered_mammal
	sprite_accessories = list(
		/datum/sprite_accessory/penis/tapered_mammal,
		)

/datum/customizer_choice/organ/penis/tapered
	name = "Tapered Penis"
	organ_type = /obj/item/organ/penis/tapered
	sprite_accessories = list(
		/datum/sprite_accessory/penis/tapered,
		)

/datum/customizer_choice/organ/penis/tapered_double
	name = "Hemi Tapered Penis"
	organ_type = /obj/item/organ/penis/tapered
	sprite_accessories = list(
		/datum/sprite_accessory/penis/hemi,
		)

/datum/customizer_choice/organ/penis/tapered_double_knot
	name = "Knotted Hemi Tapered Penis"
	organ_type = /obj/item/organ/penis/tapered
	sprite_accessories = list(
		/datum/sprite_accessory/penis/hemiknot,
		)

/datum/customizer_choice/organ/penis/barbed
	name = "Barbed Penis"
	organ_type = /obj/item/organ/penis/barbed
	sprite_accessories = list(
		/datum/sprite_accessory/penis/barbknot,
		)

/datum/customizer_choice/organ/penis/barbed_knotted
	name = "Barbed Knotted Penis"
	organ_type = /obj/item/organ/penis/barbed_knotted
	sprite_accessories = list(
		/datum/sprite_accessory/penis/barbknot,
		)

/datum/customizer_choice/organ/penis/tentacle
	name = "Tentacle Penis"
	organ_type = /obj/item/organ/penis/tentacle
	sprite_accessories = list(
		/datum/sprite_accessory/penis/tentacle,
		)

/datum/customizer/organ/testicles
	abstract_type = /datum/customizer/organ/testicles
	name = "Testicles"
	allows_disabling = TRUE
	default_disabled = TRUE
	gender_enabled = MALE

/datum/customizer/organ/testicles/is_allowed(datum/preferences/prefs)
	return TRUE

/datum/customizer_choice/organ/testicles
	abstract_type = /datum/customizer_choice/organ/testicles
	name = "Testicles"
	organ_type = /obj/item/organ/testicles
	organ_dna_type = /datum/organ_dna/testicles
	customizer_entry_type = /datum/customizer_entry/organ/testicles
	organ_slot = ORGAN_SLOT_TESTICLES
	var/can_customize_size = TRUE

/datum/customizer_choice/organ/testicles/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	testicles_entry.ball_size = sanitize_integer(testicles_entry.ball_size, MIN_TESTICLES_SIZE, MAX_TESTICLES_SIZE, DEFAULT_TESTICLES_SIZE)

/datum/customizer_choice/organ/testicles/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/testicles/testicles_dna = organ_dna
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	if(can_customize_size)
		testicles_dna.ball_size = testicles_entry.ball_size
	testicles_dna.virility = testicles_entry.virility

/datum/customizer_choice/organ/testicles/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	if(can_customize_size)
		dat += "<br>Ball size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=ball_size''>[find_key_by_value(GLOB.named_ball_sizes, testicles_entry.ball_size)]</a>"
	dat += "<br>Virile: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=virile''>[testicles_entry.virility ? "Virile" : "Sterile"]</a>"

/datum/customizer_choice/organ/testicles/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/testicles/testicles_entry = entry
	switch(href_list["customizer_task"])
		if("ball_size")
			var/named_size = input(user, "Choose your ball size:", "Character Preference", find_key_by_value(GLOB.named_ball_sizes, testicles_entry.ball_size)) as anything in GLOB.named_ball_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_ball_sizes[named_size]
			testicles_entry.ball_size = sanitize_integer(new_size, MIN_TESTICLES_SIZE, MAX_TESTICLES_SIZE, DEFAULT_TESTICLES_SIZE)
		if("virile")
			testicles_entry.virility = !testicles_entry.virility

/datum/customizer/organ/testicles/external
	customizer_choices = list(/datum/customizer_choice/organ/testicles/external)

/datum/customizer/organ/testicles/human
	customizer_choices = list(/datum/customizer_choice/organ/testicles/human)

/datum/customizer/organ/testicles/internal
	customizer_choices = list(/datum/customizer_choice/organ/testicles/internal)

/datum/customizer/organ/testicles/anthro
	customizer_choices = list(
		/datum/customizer_choice/organ/testicles/external,
		/datum/customizer_choice/organ/testicles/internal,
	)

/datum/customizer_choice/organ/testicles/external
	name = "Testicles"
	sprite_accessories = list(/datum/sprite_accessory/testicles/pair)

/datum/customizer_choice/organ/testicles/human
	name = "Testicles"
	sprite_accessories = list(/datum/sprite_accessory/testicles/pair)
	allows_accessory_color_customization = FALSE

/datum/customizer_choice/organ/testicles/internal
	name = "Internal testicles"
	organ_type = /obj/item/organ/testicles/internal
	sprite_accessories = null
	can_customize_size = FALSE

/datum/customizer_entry/organ/testicles
	var/ball_size = DEFAULT_TESTICLES_SIZE
	var/virility = TRUE

/datum/customizer/organ/breasts
	abstract_type = /datum/customizer/organ/breasts
	name = "Breasts"
	allows_disabling = TRUE
	default_disabled = TRUE
	gender_enabled = FEMALE

/datum/customizer/organ/breasts/is_allowed(datum/preferences/prefs)
	return TRUE

/datum/customizer_choice/organ/breasts
	abstract_type = /datum/customizer_choice/organ/breasts
	name = "Breasts"
	customizer_entry_type = /datum/customizer_entry/organ/breasts
	organ_type = /obj/item/organ/breasts
	organ_slot = ORGAN_SLOT_BREASTS
	organ_dna_type = /datum/organ_dna/breasts

/datum/customizer_choice/organ/breasts/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	breasts_entry.breast_size = sanitize_integer(breasts_entry.breast_size, MIN_BREASTS_SIZE, MAX_BREASTS_SIZE, DEFAULT_BREASTS_SIZE)

/datum/customizer_choice/organ/breasts/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/breasts/breasts_dna = organ_dna
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	breasts_dna.breast_size = breasts_entry.breast_size
	breasts_dna.lactating = breasts_entry.lactating

/datum/customizer_choice/organ/breasts/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	dat += "<br>Breast size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=breast_size''>[find_key_by_value(GLOB.named_breast_sizes, breasts_entry.breast_size)]</a>"
	dat += "<br>Lactation: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=lactating''>[breasts_entry.lactating ? "Enabled" : "Disabled"]</a>"

/datum/customizer_choice/organ/breasts/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/breasts/breasts_entry = entry
	switch(href_list["customizer_task"])
		if("breast_size")
			var/named_size = input(user, "Choose your breast size:", "Character Preference", find_key_by_value(GLOB.named_breast_sizes, breasts_entry.breast_size)) as anything in GLOB.named_breast_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_breast_sizes[named_size]
			breasts_entry.breast_size = sanitize_integer(new_size, MIN_BREASTS_SIZE, MAX_BREASTS_SIZE, DEFAULT_BREASTS_SIZE)
		if("lactating")
			breasts_entry.lactating = !breasts_entry.lactating

/datum/customizer_entry/organ/breasts
	var/breast_size = DEFAULT_BREASTS_SIZE
	var/lactating = FALSE

/datum/customizer/organ/breasts/human
	customizer_choices = list(/datum/customizer_choice/organ/breasts/human)

/datum/customizer_choice/organ/breasts/human
	sprite_accessories = list(/datum/sprite_accessory/breasts/pair)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/breasts/animal
	customizer_choices = list(/datum/customizer_choice/organ/breasts/animal)

/datum/customizer_choice/organ/breasts/animal
	sprite_accessories = list(
		/datum/sprite_accessory/breasts/pair,
		/datum/sprite_accessory/breasts/quad,
		/datum/sprite_accessory/breasts/sextuple,
		)

/datum/customizer/organ/vagina
	abstract_type = /datum/customizer/organ/vagina
	name = "Vagina"
	allows_disabling = TRUE
	default_disabled = TRUE
	gender_enabled = FEMALE

/datum/customizer/organ/vagina/is_allowed(datum/preferences/prefs)
	return TRUE

/datum/customizer_choice/organ/vagina
	abstract_type = /datum/customizer_choice/organ/vagina
	name = "Vagina"
	customizer_entry_type = /datum/customizer_entry/organ/vagina
	organ_type = /obj/item/organ/vagina
	organ_slot = ORGAN_SLOT_VAGINA
	organ_dna_type = /datum/organ_dna/vagina

/datum/customizer_entry/organ/vagina
	var/fertility = TRUE

/datum/customizer_choice/organ/vagina/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/vagina/vagina_dna = organ_dna
	var/datum/customizer_entry/organ/vagina/vagina_entry = entry
	vagina_dna.fertility = vagina_entry.fertility

/datum/customizer_choice/organ/vagina/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/vagina/vagina_entry = entry
	dat += "<br>Fertile: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=fertile''>[vagina_entry.fertility ? "Fertile" : "Sterile"]</a>"

/datum/customizer_choice/organ/vagina/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/vagina/vagina_entry = entry
	switch(href_list["customizer_task"])
		if("fertile")
			vagina_entry.fertility = !vagina_entry.fertility
			

/datum/customizer/organ/vagina/human
	customizer_choices = list(/datum/customizer_choice/organ/vagina/human)

/datum/customizer_choice/organ/vagina/human
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/vagina/human_anthro
	customizer_choices = list(/datum/customizer_choice/organ/vagina/human_anthro)

/datum/customizer_choice/organ/vagina/human_anthro
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		/datum/sprite_accessory/vagina/extrahairy,
		)
	allows_accessory_color_customization = TRUE

/datum/customizer/organ/vagina/animal
	customizer_choices = list(/datum/customizer_choice/organ/vagina/animal)

/datum/customizer_choice/organ/vagina/animal
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		/datum/sprite_accessory/vagina/spade,
		/datum/sprite_accessory/vagina/furred,
		)

/datum/customizer/organ/vagina/anthro
	customizer_choices = list(/datum/customizer_choice/organ/vagina/anthro)

/datum/customizer_choice/organ/vagina/anthro
	sprite_accessories = list(
		/datum/sprite_accessory/vagina/human,
		/datum/sprite_accessory/vagina/gaping,
		/datum/sprite_accessory/vagina/hairy,
		/datum/sprite_accessory/vagina/spade,
		/datum/sprite_accessory/vagina/furred,
		/datum/sprite_accessory/vagina/cloaca,
		)

/datum/customizer_entry/organ/belly
	var/belly_size = DEFAULT_BELLY_SIZE

/datum/customizer/organ/belly
	abstract_type = /datum/customizer/organ/belly
	name = "Belly"
	allows_disabling = FALSE
	default_disabled = FALSE

/datum/customizer/organ/belly/is_allowed(datum/preferences/prefs)
	return TRUE

/datum/customizer_choice/organ/belly
	abstract_type = /datum/customizer_choice/organ/belly
	name = "Belly"
	customizer_entry_type = /datum/customizer_entry/organ/belly
	organ_type = /obj/item/organ/belly
	organ_slot = ORGAN_SLOT_BELLY
	organ_dna_type = /datum/organ_dna/belly

/datum/customizer_choice/organ/belly/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/belly/belly_entry = entry
	belly_entry.belly_size = sanitize_integer(belly_entry.belly_size, MIN_BELLY_SIZE, MAX_BELLY_SIZE, DEFAULT_BELLY_SIZE)

/datum/customizer_choice/organ/belly/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/belly/belly_dna = organ_dna
	var/datum/customizer_entry/organ/belly/belly_entry = entry
	belly_dna.belly_size = belly_entry.belly_size

/datum/customizer_choice/organ/belly/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/belly/belly_entry = entry
	dat += "<br>Belly size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=belly_size''>[find_key_by_value(GLOB.named_belly_sizes, belly_entry.belly_size)]</a>"

/datum/customizer_choice/organ/belly/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/belly/belly_entry = entry
	switch(href_list["customizer_task"])
		if("belly_size")
			var/named_size = input(user, "Choose your belly size:", "Character Preference", find_key_by_value(GLOB.named_belly_sizes, belly_entry.belly_size)) as anything in GLOB.named_belly_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_belly_sizes[named_size]
			belly_entry.belly_size = sanitize_integer(new_size, MIN_BELLY_SIZE, MAX_BELLY_SIZE, DEFAULT_BELLY_SIZE)

/datum/customizer/organ/belly/human
	customizer_choices = list(/datum/customizer_choice/organ/belly/human)

/datum/customizer_choice/organ/belly/human
	sprite_accessories = list(/datum/sprite_accessory/belly)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/belly/animal
	customizer_choices = list(/datum/customizer_choice/organ/belly/animal)

/datum/customizer_choice/organ/belly/animal
	sprite_accessories = list(
		/datum/sprite_accessory/belly
		)

/mob/living/carbon/verb/changebellysize()
	set name = "Change Belly Size"
	set category = "Vore"
	set desc = "Change the size of your belly"
	change_belly_size_customizer(src)

/mob/living/carbon/proc/change_belly_size_customizer(mob/living/carbon/user) // This could have been done better, but i'm too stupid and tired to get something out of it
	var/obj/item/organ/belly/_belly = getorganslot("belly")
	var/datum/preferences/prefs = user.client.prefs
	var/datum/customizer_entry/organ/belly/belly_entry = null
	if(!_belly)
		to_chat(user, "<span class='warning'>What belly?</span>")
		return
	if (!prefs)
	{
		return
	}
 
	for (var/datum/customizer_entry/entry in prefs.customizer_entries)
	{
		if (istype(entry, /datum/customizer_entry/organ/belly))
		{
			belly_entry = entry
			break
		}
	}

	var/named_size = input(user, "Choose your belly size:", "Belly", find_key_by_value(GLOB.named_belly_sizes, belly_entry.belly_size)) as anything in GLOB.named_belly_sizes
    
	if (isnull(named_size))
		return

	var/new_size = GLOB.named_belly_sizes[named_size]

	belly_entry.belly_size = sanitize_integer(new_size, MIN_BELLY_SIZE, MAX_BELLY_SIZE, DEFAULT_BELLY_SIZE)

	_belly.belly_size = belly_entry.belly_size
	user.regenerate_icons()

/datum/customizer_entry/organ/butt
	var/organ_size = DEFAULT_BUTT_SIZE

/datum/customizer/organ/butt
	abstract_type = /datum/customizer/organ/butt
	name = "Butt"
	allows_disabling = FALSE
	default_disabled = FALSE

/datum/customizer_choice/organ/butt
	abstract_type = /datum/customizer_choice/organ/butt
	name = "Butt"
	customizer_entry_type = /datum/customizer_entry/organ/butt
	organ_type = /obj/item/organ/butt
	organ_slot = ORGAN_SLOT_BUTT
	organ_dna_type = /datum/organ_dna/butt

/datum/customizer_choice/organ/butt/validate_entry(datum/preferences/prefs, datum/customizer_entry/entry)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	butt_entry.organ_size = sanitize_integer(butt_entry.organ_size, MIN_BUTT_SIZE, MAX_BUTT_SIZE, DEFAULT_BUTT_SIZE)

/datum/customizer_choice/organ/butt/imprint_organ_dna(datum/organ_dna/organ_dna, datum/customizer_entry/entry, datum/preferences/prefs)
	..()
	var/datum/organ_dna/butt/butt_dna = organ_dna
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	butt_dna.organ_size = butt_entry.organ_size

/datum/customizer_choice/organ/butt/generate_pref_choices(list/dat, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	dat += "<br>Butt size: <a href='?_src_=prefs;task=change_customizer;customizer=[customizer_type];customizer_task=organ_size''>[find_key_by_value(GLOB.named_butt_sizes, butt_entry.organ_size)]</a>"

/datum/customizer_choice/organ/butt/handle_topic(mob/user, list/href_list, datum/preferences/prefs, datum/customizer_entry/entry, customizer_type)
	..()
	var/datum/customizer_entry/organ/butt/butt_entry = entry
	switch(href_list["customizer_task"])
		if("organ_size")
			var/named_size = input(user, "Choose your butt size:", "Character Preference", find_key_by_value(GLOB.named_butt_sizes, butt_entry.organ_size)) as anything in GLOB.named_butt_sizes
			if(isnull(named_size))
				return
			var/new_size = GLOB.named_butt_sizes[named_size]
			butt_entry.organ_size = sanitize_integer(new_size, MIN_BUTT_SIZE, MAX_BUTT_SIZE, DEFAULT_BUTT_SIZE)

/datum/customizer/organ/butt/human
	customizer_choices = list(/datum/customizer_choice/organ/butt/human)

/datum/customizer_choice/organ/butt/human
	sprite_accessories = list(/datum/sprite_accessory/butt/pair)
	allows_accessory_color_customization = FALSE

/datum/customizer/organ/butt/animal
	customizer_choices = list(/datum/customizer_choice/organ/butt/animal)

/datum/customizer_choice/organ/butt/animal
	sprite_accessories = list(/datum/sprite_accessory/butt/pair)
