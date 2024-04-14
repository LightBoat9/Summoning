extends Node

const DESCRIPTION = "Rock"
const BASE_DAMAGE = 5
const MAX_HEALTH = 20
const BASE_SHIELD = 10
const MANA_COST = 10

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
