extends Node

const DESCRIPTION = "Heavy shielding with low health and low damage"
const BASE_DAMAGE = 1
const MAX_HEALTH = 1
const BASE_SHIELD = 50
const MANA_COST = 10

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
