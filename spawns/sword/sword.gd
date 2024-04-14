extends Node

const DESCRIPTION = ""

const BASE_DAMAGE = 20
const MAX_HEALTH = 10
const BASE_SHIELD = 0
const MANA_COST = 10

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
