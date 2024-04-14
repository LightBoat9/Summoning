extends Node2D


func explode(spawn):
	for s in get_tree().get_nodes_in_group("spawns"):
		if s.global_position.distance_to(spawn.global_position) <= 24:
			if not s.is_queued_for_deletion() and s.is_alive():
				if s.is_enemy != spawn.is_enemy:
					s.damage(10)
	$CPUParticles2D.emitting = true
	await get_tree().create_timer(1.0).timeout
	queue_free()
