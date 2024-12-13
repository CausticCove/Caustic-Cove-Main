/particles/rain
		icon = 'icons/roguetown/misc/particles.dmi'
		icon_state	= list("rain"=5, "rain2"=5, "rainold"=3, "drop"=1)
		width 		= 928
		height 		= 928
		count 		= 2500
		spawning 	= 666
		lifespan 	= 15
		fade 		= 0
//		fadein		= 0
		position 	= generator("box", list(-928,-928,0), list(928,928,0))
//		gravity 	= list(-1, -200)
		velocity = list(0, -144)

/obj/emitters
//	appearance_flags	= PIXEL_SCALE
//	screen_loc = "5.5,8"

/obj/emitters/weather //we are not put on the screen, but rather put into a vis contents for a client's image
	vis_flags = VIS_INHERIT_PLANE

/obj/emitters/weather/rain
	particles 	= new/particles/rain
	alpha = 255

/atom/movable/screen/weather/fog
	alpha = 255
	icon = 'icons/mob/screen_full.dmi'
	icon_state	= "fog_smok"
	screen_loc = "1,1"
	mouse_opacity = 0
	plane = WEATHER_PLANE

/atom/movable/screen/weather/fog/New(client/C)
	. = ..()
	var/mutable_appearance/MA = mutable_appearance(icon, "impairedoverlay1")
	add_overlay(MA)

//	animate(MA, transform = null, time = 100, loop = -1)
//	animate(transform = MT, time = 0)
//	add_overlay(MA)

//	animate(transform = matrix(), time = 30)
