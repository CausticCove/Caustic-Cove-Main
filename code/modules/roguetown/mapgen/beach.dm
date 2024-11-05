
/obj/effect/landmark/mapGenerator/rogue/beach
	mapGeneratorType = /datum/mapGenerator/beach
	endTurfX = 128
	endTurfY = 128
	startTurfX = 1
	startTurfY = 1

/datum/mapGenerator/beach
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/beach,/datum/mapGeneratorModule/beachroad,/datum/mapGeneratorModule/beachcoast)

/datum/mapGeneratorModule/beach
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt)
	excluded_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(/obj/structure/flora/newtree = 15,
							/obj/structure/flora/roguegrass/bush = 13,
							/obj/structure/flora/roguegrass = 40,
							/obj/structure/flora/roguegrass/maneater = 16,
							/obj/item/natural/stone = 18,
							/obj/item/natural/rock = 2,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/closet/dirthole/closed/loot=3,
							/obj/structure/flora/roguetree/burnt = 3)
	spawnableTurfs = list(/turf/open/floor/rogue/dirt/road=5)
	allowed_areas = list(/area/rogue/outdoors/beach/forest)

/datum/mapGeneratorModule/beachroad
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS|CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/floor/rogue/dirt/road)
	spawnableAtoms = list(	/obj/item/natural/stone = 11,
							/obj/item/grown/log/tree/stick = 1)

/datum/mapGeneratorModule/beachcoast
	clusterCheckFlags = CLUSTER_CHECK_DIFFERENT_ATOMS
	allowed_turfs = list(/turf/open/water/ocean)
	spawnableAtoms = list(/obj/structure/roguerock=20, /obj/structure/glowshroom = 3)
	allowed_areas = list(/area/rogue/outdoors/beach)
