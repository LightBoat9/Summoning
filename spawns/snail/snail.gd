extends Node

const DESCRIPTION = "Rolls quickly into battle dealing 10 damage on first impact."
const ROLLING_TEXTURE = preload("res://spawns/snail/snail_rolling.png")
const SNAIL_TEXTURE = preload("res://spawns/snail/snail.png")

const BASE_DAMAGE = 5
const MAX_HEALTH = 30
const BASE_SHIELD = 30
const MANA_COST = 15

var rolling = false

func spawn_initialize(spawn):
	spawn.base_damage = BASE_DAMAGE
	spawn.max_health = MAX_HEALTH
	spawn.health = MAX_HEALTH
	spawn.shield = BASE_SHIELD
	spawn.mana_cost = MANA_COST
	spawn.sprite.texture = ROLLING_TEXTURE
	spawn.move_speed = 32
	rolling = true
	
func spawn_collide_enemy(spawn, enemy):
	if rolling:
		enemy.damage(10)
		spawn.sprite.texture = SNAIL_TEXTURE
		spawn.move_speed = 8
		rolling = false
		spawn.play_collide()
