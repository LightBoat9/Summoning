extends Node2D


var direction = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("recall")
	
func recall():
	var furthest = null
	for spawn in get_tree().get_nodes_in_group("spawns"):
		if spawn.direction == -direction and spawn.is_enemy:
			if not furthest or furthest.global_position.distance_to(global_position) > spawn.global_position.distance_to(global_position):
				furthest = spawn
	
	if furthest:
		furthest.global_position = direction * Vector2(16, 16) * 7.5
		furthest.damage(10)
