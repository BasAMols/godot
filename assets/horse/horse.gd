extends Node2D

var animation: AnimatedSprite2D = null

var speed = 60
@export var direction = 1
var velocity = 0
var sprintMultiplier = 3

var deceleration = 0.4
var acceleration = 0.2

func _ready() -> void:
	animation = get_node("animatedSprite2d")
	play_animation("Idle", 1)
	scale.x = direction


func _process(delta):
	if not get_meta("camera_follow"):
		play_animation("Idle", 1)

		velocity = 0
		return


	deceleration = 0.4 * delta * 10
	acceleration = 0.2 * delta * 10

	var sprint: bool = Input.is_action_pressed("shift")
	if sprint:
		acceleration *= sprintMultiplier
		deceleration *= sprintMultiplier

	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		direction = -1
		if (velocity > 0):
			velocity = clamp(velocity - deceleration, 0, sprintMultiplier)
		else:
			velocity = clamp(velocity - acceleration, -sprintMultiplier, sprintMultiplier)

	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		direction = 1
		if (velocity < 0):
			velocity = clamp(velocity + deceleration, -sprintMultiplier, 0)
		else:
			velocity = clamp(velocity + acceleration, -sprintMultiplier, sprintMultiplier)

	else:
		if (velocity < 0):
			velocity = clamp(velocity + deceleration, -sprintMultiplier, 0)
		elif (velocity > 0):
			velocity = clamp(velocity - deceleration, 0, sprintMultiplier)

	if not sprint:
		velocity = clamp(velocity, -1, 1)

	if (velocity > -0.1 and velocity < 0.1):
		play_animation("Idle", 1)
	elif (velocity > 1 or velocity < -1):
		play_animation("Run", abs(velocity) / sprintMultiplier)
	else:
		play_animation("Walk", abs(velocity))

	position.x += velocity * speed * delta
	scale.x = direction

var current_animation: String = ""
func play_animation(animation_name: String, speed_scale: float):
	if current_animation != animation_name:
		current_animation = animation_name
		animation.play(animation_name)
		animation.frame = randi() % animation.sprite_frames.get_frame_count(animation_name)

	animation.speed_scale = speed_scale * 0.8
