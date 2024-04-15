extends Node

const DESCRIPTION = "Pass through units dealing 20 damage to enemies. Ignoring shields."
const BASE_DAMAGE = 20
const MAX_HEALTH = 1
const BASE_SHIELD = 0
const MANA_COST = 15

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
	spawn.ignore_spawns = true
	spawn.collision_damage = BASE_DAMAGE
	spawn.move_speed = 16
