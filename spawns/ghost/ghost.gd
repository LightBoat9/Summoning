extends Node

const DESCRIPTION = "Pass through enemies damaging them"
const BASE_DAMAGE = 10
const MAX_HEALTH = 1
const BASE_SHIELD = 0
const MANA_COST = 10

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
	spawn.ignore_enemies = true
	spawn.collision_damage = BASE_DAMAGE
