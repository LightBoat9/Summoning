extends Node


const Spawn = preload("res://spawns/spawn/spawn.tscn")


@onready var World = get_tree().root.get_child(get_tree().root.get_child_count()-1)
@onready var Interface = World.get_node("CanvasLayer/Interface")
@onready var HealthBar = Interface.get_node("Bars/HealthBar")
@onready var ManaBar = Interface.get_node("Bars/ManaBar")
@onready var Spells = Interface.get_node("HB/Spells")
@onready var RunesParent = World.get_node("CanvasLayer/Runes")
@onready var Runes = World.get_node("CanvasLayer/Runes/HB")
@onready var Player = World.get_node("Player")
