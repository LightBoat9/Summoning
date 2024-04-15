extends Node

enum Spells {
	Fireball,
	Recall,
	ForceBack
}

const SPELL_DAMAGE = {
	Spells.Fireball: 30,
	Spells.ForceBack: 10
}

const SPELL_COST = {
	Spells.Fireball: 10,
	Spells.Recall: 10,
	Spells.ForceBack: 10
}

const SPELL_INSTANCES = {
	Spells.Fireball: preload("res://spells/fireball/fireball.tscn"),
	Spells.Recall: preload("res://spells/recall/recall.tscn"),
	Spells.ForceBack: preload("res://spells/force_back/force_back.tscn"),
}

const SPELL_DESCRIPTIONS = {
	Spells.Fireball: "Single target projectile",
	Spells.Recall: "Return the last unit in the row and bring to full health",
	Spells.ForceBack: "Send the first enemy to the end of the row and deal 10 damage"
}

const SPELL_SPRITES = {
	Spells.Fireball: preload("res://spells/fireball/fireball_base.png"),
	Spells.Recall: preload("res://spells/recall/recall.png"),
	Spells.ForceBack: preload("res://spells/force_back/force_back.png")
}

func get_spell(spell_index):
	var spell = SPELL_INSTANCES[spell_index].instantiate()
	return spell
	
	
func get_title(type):
	return Spells.keys()[type]
	
	
func get_description(type):
	return SPELL_DESCRIPTIONS[type]
	
	
func get_damage(type):
	if type in SPELL_DAMAGE:
		return SPELL_DAMAGE[type]
	else:
		return 0
	
	
func get_mana(type):
	return SPELL_COST[type]
