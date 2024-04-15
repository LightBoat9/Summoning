extends Node

const DESCRIPTION = "Heavy shielding with low damage and health"
const BASE_DAMAGE = 1
const MAX_HEALTH = 10
const BASE_SHIELD = 80
const MANA_COST = 15

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
