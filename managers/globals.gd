extends Node


const Spawn = preload("res://spawns/spawn/spawn.tscn")


@onready var World = get_tree().root.get_child(get_tree().root.get_child_count()-1)
@onready var Interface = World.get_node("CanvasLayer/Interface")
@onready var HealthBar = Interface.get_node("Bars/HB/HealthBar")
@onready var HealthBarLabel = Interface.get_node("Bars/HB/Label")
@onready var ManaBar = Interface.get_node("Bars/HB2/ManaBar")
@onready var ManaBarLabel = Interface.get_node("Bars/HB2/Label")
@onready var Points = Interface.get_node("Bars/Points")
@onready var Spells = Interface.get_node("HB/Spells")
@onready var RunesParent = World.get_node("CanvasLayer/Runes")
@onready var Runes = World.get_node("CanvasLayer/Runes/VB/HB")
@onready var Player = World.get_node("Player")
@onready var EndScreen = World.get_node("CanvasLayer/EndScreen")
@onready var EndScreenScore = World.get_node("CanvasLayer/EndScreen/VBoxContainer/Label2")


func _enter_tree():
	reload()


func reload():
	World = get_tree().root.get_child(get_tree().root.get_child_count()-1)
	Interface = World.get_node("CanvasLayer/Interface")
	HealthBar = Interface.get_node("Bars/HB/HealthBar")
	HealthBarLabel = Interface.get_node("Bars/HB/Label")
	ManaBar = Interface.get_node("Bars/HB2/ManaBar")
	ManaBarLabel = Interface.get_node("Bars/HB2/Label")
	Points = Interface.get_node("Bars/Points")
	Spells = Interface.get_node("HB/Spells")
	RunesParent = World.get_node("CanvasLayer/Runes")
	Runes = World.get_node("CanvasLayer/Runes/VB/HB")
	Player = World.get_node("Player")
	EndScreen = World.get_node("CanvasLayer/EndScreen")
	EndScreenScore = World.get_node("CanvasLayer/EndScreen/VBoxContainer/Label2")


var points = 0

func add_points(amount):
	points += amount
	Points.text = "%09d" % points
	
	
func end_game():
	EndScreen.visible = true
	EndScreenScore.text = "Final Score: %09d" % points
	get_tree().paused = true
