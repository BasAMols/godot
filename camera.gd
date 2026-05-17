extends Camera2D

var follow: Node2D = null
var horse: Node2D = null
var character: Node2D = null

func _ready() -> void:
	get_node("control/hFlowContainer/switchButton").pressed.connect(on_switch_button_pressed)
	horse = get_parent().get_node("horse")
	character = get_parent().get_node("character")
	set_follow_target("character")

func set_follow_target(target: String) -> void:
	if target == "horse": 
		follow = horse
		character.set_meta("camera_follow", false)
		horse.set_meta("camera_follow", true)
	else:
		follow = character
		character.set_meta("camera_follow", true)
		horse.set_meta("camera_follow", false)

func on_switch_button_pressed() -> void:
	set_follow_target("character" if follow == horse else "horse")

func _process(_delta: float) -> void:
	global_position.x = follow.global_position.x
