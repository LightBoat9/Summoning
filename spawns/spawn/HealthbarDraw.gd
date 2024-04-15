extends Node2D


func _draw():
	var p = get_parent()
	if p.shield > 0:
		draw_rect(Rect2(-6, -17, 12 * (p.shield / float(p.max_shield)), 1), Color("c1d9f2"), true)
	draw_rect(Rect2(-6, -16, 12 * (p.health / float(p.max_health)), 1), Color("a52639"), true)
	draw_rect(Rect2(-6, -15, 12 * (p.health / float(p.max_health)), 1), Color(0, 0, 0, 100.0/255.0), true)
