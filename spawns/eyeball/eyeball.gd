extends Node

const DESCRIPTION = "Petrify enemies on first contact stunning them for 2 seconds."
const BASE_DAMAGE = 5
const MAX_HEALTH = 30
const BASE_SHIELD = 0
const MANA_COST = 10

var stunned_enemies = []

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
	
	
func spawn_collide_enemy(spawn, enemy):
	if enemy not in stunned_enemies:
		stunned_enemies.append(enemy)
		enemy.state = 2
