/obj/item/reagent_containers/food/snacks/butterslice
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = "butter_slice"
	name = "butter"
	desc = "A small slice of creamy butter!"
	foodtype = DAIRY
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	slices_num = 0

/obj/item/reagent_containers/food/snacks/fat
	icon = 'icons/roguetown/items/food.dmi'
	name = "fat"
	desc = "A chunk of rendered animal fat, sustenance and fuel to the living beings."
	icon_state = "fat"
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	eat_effect = /datum/status_effect/debuff/uncookedfood
