extends Node

enum Spells {
	Fireball
}

const SPELL_DAMAGE = {
	Spells.Fireball: 10
}

const SPELL_COST = {
	Spells.Fireball: 10
}

const Fireball = preload("res://spells/fireball/fireball.tscn")

const SPELL_INSTANCES = {
	Spells.Fireball: Fireball
}

const SPELL_DESCRIPTIONS = {
	Spells.Fireball: "Single target projectile"
}

const SPELL_SPRITES = {
	Spells.Fireball: preload("res://spells/fireball/fireball_base.png")
}

func get_spell(spell_index):
	var spell = SPELL_INSTANCES[Spells.Fireball].instantiate()
	return spell
	
	
func get_title(type):
	return Spells.keys()[type]
	
	
func get_description(type):
	return SPELL_DESCRIPTIONS[type]
	
	
func get_damage(type):
	return SPELL_DAMAGE[type]
	
	
func get_mana(type):
	return SPELL_COST[type]
