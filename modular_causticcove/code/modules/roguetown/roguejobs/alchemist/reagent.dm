// Oz to unit ration is a 1:3. If you intend on people drinking only 2 sips of a potion to get a buff, you must have 11u, as each time a player sips,
// they consume 6u of reagent, or 6u. You must make sure to keep the overdose threshold under one unit (if 20u, do 19u). Make sure that removing the
// reagent, that you remove the actual amount of reagent needed to get the buff. I.E. 20u of intellect pot, which is 4 sips, 6u * 4 sips = 20 - Lynx

// When making a potion remember that these can stack, people can combine them together in a bottle, this may be changed in the future with
// reactions that cause inverse effects due to "vicious mixing" where potions will have random effects. I.E. Exploding in your face, turning into
// new types of potions, turning into acid, etc. Think Noita terms of potion mixing. Yes, I will 100% look into adding rare potions that are randomized
// each round because that sounds awesome. - Lynx

//Brews are NOT the same as potions.

/////////////////
//BREW REAGENTS//
/////////////////
/datum/reagent/medicine/ravoxbrew
	name = "Ravox Brew"
	description = "Increases one's strength, but... at what cost?"
	reagent_state = LIQUID
	color = "#e03400"
	taste_description = "broiling rage"
	overdose_threshold = 19
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	alpha = 255

/datum/reagent/medicine/ravoxbrew/overdose_process(mob/living/M)
	M.apply_status_effect(/datum/status_effect/buff/ravoxbuff)
	if(holder.has_reagent(/datum/reagent/medicine/ravoxbrew))
		M.reagents.add_reagent(/datum/reagent/berrypoison, 5)
		holder.remove_reagent(/datum/reagent/medicine/ravoxbrew, 20)
	. = ..()

	
/datum/reagent/medicine/abyssorbrew
	name = "Abyssor's Brew"
	description = "Float freely amongst the liquid, yet wonder how to walk..."
	reagent_state = LIQUID
	color = "#9ee4ff"
	taste_description = "salty shores"
	overdose_threshold = 19
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	alpha = 255

/datum/reagent/medicine/abyssorbrew/overdose_process(mob/living/M)
	//Make sure to not accidentally apply this trait twice.
	if(HAS_TRAIT(M, TRAIT_ABYSSORS_BLESSING))
		if(holder.has_reagent(/datum/reagent/medicine/abyssorbrew))
			holder.remove_reagent(/datum/reagent/medicine/abyssorbrew, 20)
		return
	M.apply_status_effect(/datum/status_effect/buff/abyssorbuff)
	if(holder.has_reagent(/datum/reagent/medicine/abyssorbrew))
		holder.remove_reagent(/datum/reagent/medicine/abyssorbrew, 20)
	. = ..()

///////////////////
//POTION REAGENTS//
///////////////////
/datum/reagent/medicine/intellectpot
	name = "Intellect Potion"
	description = "Increases one's Intelligence and Perception."
	reagent_state = LIQUID
	color = "#922296"
	taste_description = "whispering insight"
	overdose_threshold = 19
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/intellectpot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/intellectbuff)
	if(holder.has_reagent(/datum/reagent/medicine/intellectpot))
		holder.remove_reagent(/datum/reagent/medicine/intellectpot, 20)
	..()
	. = 1 

/datum/reagent/medicine/fortitudepot
	name = "Strength Potion"
	description = "Increases one's Strength."
	reagent_state = LIQUID
	color = "#d46000"
	taste_description = "raw fortitude"
	overdose_threshold = 19
	metabolization_rate = 0.2 * REAGENTS_METABOLISM
	alpha = 200

/datum/reagent/medicine/fortitudepot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/fortitudebuff)
	if(holder.has_reagent(/datum/reagent/medicine/fortitudepot))
		holder.remove_reagent(/datum/reagent/medicine/fortitudepot, 20)
	..()
	. = 1 

/datum/reagent/medicine/swiftnesspot
	name = "Swiftness Potion"
	description = "Increases one's Speed."
	reagent_state = LIQUID
	color = "#7efff9"
	taste_description = "fleeting swirls"
	overdose_threshold = 16
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/swiftnesspot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/swiftnessbuff)
	if(holder.has_reagent(/datum/reagent/medicine/swiftnesspot))
		holder.remove_reagent(/datum/reagent/medicine/swiftnesspot, 20)
	..()
	. = 1 

/datum/reagent/mfire
	name = "Malum's Fire"
	description = "Divine Burning."
	color = "#ffc229" 
	taste_description = "Malum's blessing"
	overdose_threshold = 19
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	alpha = 255

/datum/reagent/mfire/overdose_start(mob/living/M)
	if(HAS_TRAIT(M, TRAIT_MALUMSGRACE)) 
		M.apply_status_effect(/datum/status_effect/buff/mfire)
		if(holder.has_reagent(/datum/reagent/mfire))
			holder.remove_reagent(/datum/reagent/mfire, 15)
	if(HAS_TRAIT(M, TRAIT_CRACKHEAD)) // Baotha says you can do this drug too
		M.apply_status_effect(/datum/status_effect/buff/mfire)
		if(holder.has_reagent(/datum/reagent/mfire))
			holder.remove_reagent(/datum/reagent/mfire, 15)
	else
		M.adjust_fire_stacks(1) // You snorted divine fire and you're not one of his faithful? Burn.
		var/burndmg = max(0.3*M.fire_stacks, 0.3)
		M.adjustFireLoss(burndmg, 0)
	..()
	. = 1
//////////////////
//EFFECT POTIONS//
//////////////////

/datum/reagent/medicine/virilitypot
	name = "Virlity Potion"
	description = "Increases one's virility."
	reagent_state = LIQUID
	color = "#ffa6f8"
	taste_description = "aching virility"
	overdose_threshold = 9
	metabolization_rate = 0.2 * REAGENTS_METABOLISM 
	alpha = 225

/datum/reagent/medicine/virilitypot/overdose_process(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/virilitybuff)
	if(holder.has_reagent(/datum/reagent/medicine/virilitypot))
		holder.remove_reagent(/datum/reagent/medicine/virilitypot, 10)
	.. ()
	. = 1 

/////////////////////
//CRAFTING REAGENTS//
/////////////////////

//Ported from Hearthstone and tweaked.
/obj/item/reagent_containers/powder/sublimate // Gotten through alchemy, combine milled gemstone with moondust. Higher value dust, more sublimate.
	name = "arcyne sublimate"
	desc = "The stuff of gizaels and magic."
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "sublimate"
	volume = 30
	list_reagents = list(
		/datum/reagent/gemdust = 5,
		/datum/reagent/medicine/manapot = 25) // Enough manna pot to give 20% fatigue bar, but gemdust to make it obnoxious compared to manna potion.
	grind_results = list(
		/datum/reagent/gemdust = 5,
		/datum/reagent/medicine/manapot = 25)


// Grinded Gems

/obj/item/reagent_containers/powder/toper
	name = "toper dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "toper_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 16

/obj/item/reagent_containers/powder/gemerald
	name = "gemerald dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "gemerald_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 33

/obj/item/reagent_containers/powder/saffira
	name = "saffira dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "saffira_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 44

/obj/item/reagent_containers/powder/blortz
	name = "blortz dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "blortz_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 70

/obj/item/reagent_containers/powder/rontz
	name = "rontz dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "rontz_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 80

/obj/item/reagent_containers/powder/dorpel
	name = "dorpel dust"
	desc = ""
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "dorpel_dust"
	volume = 5
	list_reagents = list(/datum/reagent/gemdust = 5)
	grind_results = list(/datum/reagent/gemdust = 5)
	sellprice = 97

/obj/item/reagent_containers/powder/mfire
	name = "malum's fire"
	desc = "Of mind... Of flesh..."
	gender = PLURAL
	icon = 'icons/roguetown/items/gems.dmi'
	icon_state = "mfire"
	volume = 15
	list_reagents = list(/datum/reagent/mfire = 15)
	grind_results = list(/datum/reagent/mfire = 15)
	sellprice = 300

/datum/reagent/gemdust
	name = "Gemstone Dust"
	description = "Glassy."
	color = "#d7d0be" 
	overdose_threshold = 0
	metabolization_rate = 1 * REAGENTS_METABOLISM

/datum/reagent/gemdust/on_mob_life(mob/living/carbon/M)
		M.adjust_blurriness(3)
		M.confused = max(M.confused+3,0)
		M.adjustBruteLoss(2)
		M.emote(pick("cough"))
		..()
		. = 1

