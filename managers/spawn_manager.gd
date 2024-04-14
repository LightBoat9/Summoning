extends Node


enum Spawn {
	Slime,
	Shield,
	Snail,
	Ghost,
	Golem,
	Sword,
	Bow
}


const SPAWN_SPRITES = {
	Spawn.Slime: preload("res://spawns/slime/slime.png"),
	Spawn.Shield: preload("res://spawns/shield/shield.png"),
	Spawn.Snail: preload("res://spawns/snail/snail.png"),
	Spawn.Ghost: preload("res://spawns/ghost/ghost.png"),
	Spawn.Golem: preload("res://spawns/golem/golem.png"),
	Spawn.Sword: preload("res://spawns/sword/sword.png"),
	Spawn.Bow: preload("res://spawns/bow/bow.png"),
}

const SPAWN_MANAGERS = {
	Spawn.Slime: preload("res://spawns/slime/slime.gd"),
	Spawn.Shield: preload("res://spawns/shield/shield.gd"),
	Spawn.Snail: preload("res://spawns/snail/snail.gd"),
	Spawn.Ghost: preload("res://spawns/ghost/ghost.gd"),
	Spawn.Golem: preload("res://spawns/golem/golem.gd"),
	Spawn.Sword: preload("res://spawns/sword/sword.gd"),
	Spawn.Bow: preload("res://spawns/bow/bow.gd"),
}


const SPAWN_OFFSET = Vector2(120, 120)


@onready var spawn_timer = Timer.new()
@onready var upgrade_timer = Timer.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(spawn_timer)
	spawn_timer.one_shot = false
	spawn_timer.wait_time = 5
	spawn_timer.connect("timeout", spawn_timer_timeout)
	spawn_timer.start()
	
	add_child(upgrade_timer)
	upgrade_timer.one_shot = false
	upgrade_timer.wait_time = 30
	upgrade_timer.connect("timeout", upgrade_timer_timeout)
	upgrade_timer.start()
	
func load_new_runes():
	var new_runes = []
	for i in range(Globals.Runes.get_child_count()):
		var rune = Rune.new()
		rune.set_random_type()
		var failsafe = 100
		while not is_rune_unique(rune) or rune.get_title() in new_runes:
			rune.set_random_type()
			failsafe -= 1
			if failsafe <= 0:
				break
		new_runes.append(rune.get_title())
		Globals.Runes.get_child(i).set_rune(rune)
		
	Globals.RunesParent.show_runes()
	
func is_rune_unique(rune):
	for i in range(len(Globals.Player.runes)):
		if Globals.Player.runes[i] and Globals.Player.runes[i].get_title() == rune.get_title():
			return false
	return true
	
	
func spawn():
	var spawn_type = randi() % len(Spawn.keys())
	var spawn = get_spawn(spawn_type)
	Globals.World.add_child(spawn)
	var random_direction = randi() % 2
	var random_flip = -1 if randi() % 2 == 1 else 1
	var spawn_direction = Vector2(random_flip * random_direction, random_flip * (1 - random_direction))
	spawn.global_position = SPAWN_OFFSET * spawn_direction
	spawn.direction = -spawn_direction
	spawn.is_enemy = true
	
	
func spawn_timer_timeout():
	spawn()
	
	
func upgrade_timer_timeout():
	load_new_runes()
	
	
func get_spawn(spawn_type):
	var spawn = Globals.Spawn.instantiate()
	if spawn_type in SPAWN_SPRITES:
		spawn.sprite_texture = SPAWN_SPRITES[spawn_type]
	if spawn_type in SPAWN_MANAGERS:
		spawn.spawn_manager = SPAWN_MANAGERS[spawn_type].new()
	return spawn
	
	
func get_title(type):
	return Spawn.keys()[type]
	
	
func get_description(type):
	return SPAWN_MANAGERS[type].DESCRIPTION
	
	
func get_damage(type):
	return SPAWN_MANAGERS[type].BASE_DAMAGE
	
	
func get_health(type):
	return SPAWN_MANAGERS[type].MAX_HEALTH
	
	
func get_shield(type):
	return SPAWN_MANAGERS[type].BASE_SHIELD
	
	
func get_mana(type):
	return SPAWN_MANAGERS[type].MANA_COST
