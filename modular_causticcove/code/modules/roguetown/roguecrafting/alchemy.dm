//Placeholder recipes, in heavy need of tweaking.

/////////////////
//BREW CRAFTING//
/////////////////
/datum/crafting_recipe/roguetown/alchemy/ravoxbrew
	name = "Ravox Brew"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/ravoxbrew)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/powder/sublimate = 1,
		/obj/item/natural/alchemy/volf_head = 1,
		/obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison = 2
	)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/abyssorbrew
	name = "Abyssor Brew"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/abyssorbrew)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/powder/sublimate = 1,
		/obj/item/reagent_containers/food/snacks/rogue/meat/crab = 3,
		/obj/item/reagent_containers/food/snacks/fish/eel = 1
	)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/fyritiusbrew
	name = "Fyritius Brew"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/fyritiusbrew)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/powder/sublimate = 1,
		/obj/item/reagent_containers/food/snacks/grown/rogue/fyritius = 2,
		/obj/item/rogueore/coal = 2
	)
	craftdiff = 1

///////////////////
//POTION CRAFTING//
///////////////////

/datum/crafting_recipe/roguetown/alchemy/fortitudepot
	name = "Fortitude Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/fortitudepot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/obj/item/reagent_containers/powder/sublimate = 2, 
		/obj/item/natural/alchemy/volf_head = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/swiftnesspot
	name = "Swiftness Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/swiftnesspot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/obj/item/reagent_containers/powder/sublimate = 1, 
		/obj/item/natural/alchemy/antler = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/intellectpot
	name = "Intellect Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/intellectpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/obj/item/reagent_containers/powder/sublimate = 1, 
		/obj/item/natural/bone = 2, 
		/obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed = 2 )
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/virilitypot
	name = "Virility Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/virilitypot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1, 
		/obj/item/reagent_containers/powder/sublimate = 1, 
		/obj/item/clothing/head/peaceflower = 1)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/bloodhealthpot
	name = "Blood Infused Healing Potion"
	result = list(/obj/item/reagent_containers/glass/bottle/rogue/bloodhealthpot)
	reqs = list(
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/reagent_containers/powder/sublimate = 1,
		/datum/reagent/blood = 20,
		/datum/reagent/water = 20,
		/obj/item/rogueore/gold = 1
	)
	craftdiff = 4

//////////////////////
//IMBUEMENT CRAFTING//
//////////////////////

/////////////////////
//MATERIAL CRAFTING//
/////////////////////

//Ported and tweaked from Hearthstone. Personally love this idea. Decided that it should scale in cost and skill to get more sublimate.
/datum/crafting_recipe/roguetown/alchemy/t2sub
	name = "Sublimate Toper Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/toper = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 0

/datum/crafting_recipe/roguetown/alchemy/g2sub
	name = "Sublimate Gemerald Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/gemerald = 1, 
		/obj/item/reagent_containers/powder/moondust = 1)
	craftdiff = 1

/datum/crafting_recipe/roguetown/alchemy/s2sub
	name = "Sublimate Saffira Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/saffira = 1, 
		/obj/item/reagent_containers/powder/moondust = 2)
	craftdiff = 2

/datum/crafting_recipe/roguetown/alchemy/b2sub
	name = "Sublimate Blortz Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/blortz = 1, 
		/obj/item/reagent_containers/powder/moondust = 2)
	craftdiff = 3

/datum/crafting_recipe/roguetown/alchemy/r2sub
	name = "Sublimate Rontz Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/rontz = 1, 
		/obj/item/reagent_containers/powder/moondust = 3)
	craftdiff = 4

/datum/crafting_recipe/roguetown/alchemy/d2sub
	name = "Sublimate Dorpel Dust"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/dorpel = 1, 
		/obj/item/reagent_containers/powder/moondust = 3)
	craftdiff = 5

/datum/crafting_recipe/roguetown/alchemy/m2sub
	name = "Sublimate Malum's Fire"
	result = list(
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate,
		/obj/item/reagent_containers/powder/sublimate)
	reqs = list(
		/obj/item/reagent_containers/powder/mfire = 1, 
		/obj/item/reagent_containers/powder/moondust = 4)
	craftdiff = 6
