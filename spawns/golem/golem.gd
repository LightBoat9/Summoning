extends Node

const DESCRIPTION = "High health unit"
const BASE_DAMAGE = 5
const MAX_HEALTH = 50
const BASE_SHIELD = 0
const MANA_COST = 15

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
