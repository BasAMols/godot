extends Button

@export var camera: Camera2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if camera == null:
		push_error("Switch button has no camera assigned.")
		set_process(false)

	pressed.connect(_button_pressed)


func _button_pressed() -> void:
	var index = camera.cycle_follow_target()
