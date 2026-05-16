extends Sprite2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += get_meta("Speed", 5) * delta

	if position.x > 3000:
		position.x = -3000
