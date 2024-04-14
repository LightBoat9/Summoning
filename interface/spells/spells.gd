extends GridContainer


func _ready():
	for i in range(get_child_count()):
		get_child(i).index = i
