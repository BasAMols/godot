extends Camera2D

var follow: Node2D = null
var current_index: int = 0

@export var targets: Array[Node2D] = []

func _ready() -> void:
	if targets.size() == 0:
		push_error("Camera has no target assigned.")
		set_process(false)

	switch_follow_target(0)

func switch_follow_target(index: int) -> void:
	follow = targets[index]
	for i in targets.size():
		targets[i].set_meta("camera_follow", i == index)
	current_index = index

func cycle_follow_target() -> int:
	switch_follow_target((current_index + 1) % targets.size())
	return current_index

func _process(_delta: float) -> void:
	global_position = follow.global_position
