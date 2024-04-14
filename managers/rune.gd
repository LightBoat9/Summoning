class_name Rune
extends Node


enum RuneType {
	SPAWN, SPELL
}

var rune_type = RuneType.SPAWN
var rune_type_index = SpawnManager.Spawn.Slime
	
	
func get_texture():
	if rune_type == RuneType.SPAWN:
		return SpawnManager.SPAWN_SPRITES[rune_type_index]
	else:
		return SpellManager.SPELL_SPRITES[rune_type_index]
	
	
func get_title():
	if rune_type == RuneType.SPAWN:
		return SpawnManager.get_title(rune_type_index)
	elif rune_type == RuneType.SPELL:
		return SpellManager.get_title(rune_type_index)
	
	
func get_description():
	if rune_type == RuneType.SPAWN:
		return SpawnManager.get_description(rune_type_index)
	elif rune_type == RuneType.SPELL:
		return SpellManager.get_description(rune_type_index)
	
	
func set_random_type():
	rune_type = randi() % len(RuneType.keys())
	if rune_type == RuneType.SPAWN:
		rune_type_index = randi() % len(SpawnManager.Spawn.keys())
	elif rune_type == RuneType.SPELL:
		rune_type_index = randi() % len(SpellManager.Spells.keys())
	
	
func get_damage():
	if rune_type == RuneType.SPAWN:
		return SpawnManager.get_damage(rune_type_index)
	elif rune_type == RuneType.SPELL:
		return SpellManager.get_damage(rune_type_index)
	else:
		return 0
	
func get_health():
	if rune_type == RuneType.SPAWN:
		return SpawnManager.get_health(rune_type_index)
	else:
		return 0
	
func get_shield():
	if rune_type == RuneType.SPAWN:
		return SpawnManager.get_shield(rune_type_index)
	else:
		return 0
	
func get_mana():
	if rune_type == RuneType.SPAWN:
		return SpawnManager.get_mana(rune_type_index)
	elif rune_type == RuneType.SPELL:
		return SpellManager.get_mana(rune_type_index)
	else:
		return 0
	
	
