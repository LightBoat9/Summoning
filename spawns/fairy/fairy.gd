extends Node

const DESCRIPTION = "Pass through units giving allies 20 health and 30 shield"
const BASE_DAMAGE = 0
const MAX_HEALTH = 1
const BASE_SHIELD = 0
const MANA_COST = 20

var collide_friendlies = []

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
	spawn.ignore_spawns = true
	spawn.move_speed = 32
	
func spawn_collide_friendly(spawn, friendly):
	if friendly == Globals.Player:
		return
		
	if friendly not in collide_friendlies:
		collide_friendlies.append(friendly)
		friendly.health += 20
		friendly.shield += 30
		friendly.update_max_shield()
