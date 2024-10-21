/turf/open/water/acid
	name = "acid"
	desc = "Caustic and horrible, its bubbling incessantly."
	icon_state = "acid"
	icon = 'icons/turf/roguefloor.dmi'
	water_level = 2 //waist high
	water_color = "#56ff0d"
	slowdown = 4
	swim_skill = TRUE
	wash_in = FALSE //no
	water_reagent = /datum/reagent/water/gross

/turf/open/water/acid/Initialize()
	.  = ..()
	icon_state = "acid"
