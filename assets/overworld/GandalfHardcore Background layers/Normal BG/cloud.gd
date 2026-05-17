extends Node2D

var speed: float
var right: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tex: CompressedTexture2D = get_meta("Src")
	get_node("sprite2d").texture = tex
	scale = Vector2(get_parent().get_meta("Scale"), get_parent().get_meta("Scale"))
	speed = get_parent().get_meta("Speed")
	right = get_parent().get_meta("Right")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta

	if position.x > right:
		queue_free()
