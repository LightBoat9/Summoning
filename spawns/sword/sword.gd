extends Node

const DESCRIPTION = "High attack damage"

const BASE_DAMAGE = 15
const MAX_HEALTH = 40
const BASE_SHIELD = 0
const MANA_COST = 20

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
