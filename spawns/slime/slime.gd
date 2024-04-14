extends Node


const SlimeExplosion = preload("res://spawns/slime/slime_explosion.tscn")

const DESCRIPTION = "Explodes on death deailing 10 damage"
const BASE_DAMAGE = 5
const MAX_HEALTH = 10
const BASE_SHIELD = 0
const MANA_COST = 10

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
	
	
func spawn_on_death(spawn):
	var slime_explosion = SlimeExplosion.instantiate()
	slime_explosion.global_position = spawn.global_position
	spawn.get_parent().add_child(slime_explosion)
	slime_explosion.explode(spawn)
	
