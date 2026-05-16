extends Camera2D

func _process(_delta: float) -> void:
	global_position.x = get_parent().get_node("horse").global_position.x
