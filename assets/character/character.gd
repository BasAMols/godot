extends Node2D

var outfit: AnimatedSprite2D = null
var hat: AnimatedSprite2D = null

var direction = 1
var velocity = 0
@export var speed = 60
@export var sprintMultiplier = 3
@export var deceleration = 0.4
@export var acceleration = 0.2
var single_animation: String = ""
var hold_animation: String = ""

var last_velocity: float = 0
var current_animation: String = ""

func _ready() -> void:
	outfit = get_node("outfit")
	hat = get_node("hat")
	play_animation("idle_flirty", 1)
	outfit.animation_looped.connect(on_animation_finished)

func on_animation_finished() -> void:
	if single_animation != "":
		single_animation = ""
		play_animation(current_animation)

func _process(delta):
	if not get_meta("camera_follow"):
		play_animation("idle_flirty", 1)
		hat.animation = outfit.animation
		hat.frame = outfit.frame
		hat.set_frame_and_progress(outfit.frame, outfit.frame_progress);

		velocity = 0
		return

	var dec = deceleration * delta * 10
	var acc = acceleration * delta * 10

	if Input.is_action_pressed("attack"):
		trigger_hold("sword_attack")
		
	elif hold_animation != "":
		hold_animation = ""
		play_animation(current_animation, last_velocity, true)

	var sprint: bool = Input.is_action_pressed("shift")
	if sprint:
		acc *= sprintMultiplier
		dec *= sprintMultiplier

	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") and hold_animation == "":
		direction = -1
		if (velocity > 0 || (velocity < -1 and not sprint)):
			velocity = clamp(velocity - dec, -sprintMultiplier, sprintMultiplier)
		else:
			velocity = clamp(velocity - acc, -sprintMultiplier, sprintMultiplier)

	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left") and hold_animation == "":
		direction = 1
		if (velocity < 0 || (velocity > 1 and not sprint)):
			velocity = clamp(velocity + dec, -sprintMultiplier, sprintMultiplier)
		else:
			velocity = clamp(velocity + acc, -sprintMultiplier, sprintMultiplier)

	else:
		if (velocity < 0 ):
			velocity = clamp(velocity + dec, -sprintMultiplier, 0)
		elif (velocity > 0):
			velocity = clamp(velocity - dec, 0, sprintMultiplier)

	if not sprint:
		velocity = clamp(velocity, -1, 1)

	if (velocity > -0.1 and velocity < 0.1):
		play_animation("idle_flirty", 1)
	elif (velocity > 1 or velocity < -1):
		play_animation("run", abs(velocity) / sprintMultiplier)
	else:
		play_animation("walk", abs(velocity))

	position.x += velocity * speed * delta
	scale.x = direction

	hat.animation = outfit.animation
	hat.frame = outfit.frame
	hat.set_frame_and_progress(outfit.frame, outfit.frame_progress);

func trigger_single(animation_name: String) -> void:
	if single_animation != "":
		return
		
	single_animation = animation_name
	outfit.play(animation_name)
	outfit.speed_scale = 0.8

func trigger_hold(animation_name: String) -> void:
	if hold_animation != animation_name:
		outfit.play(animation_name)

	hold_animation = animation_name
	outfit.speed_scale = 0.8


func play_animation(animation_name: String, speed_scale: float = last_velocity, force: bool = false):
	if (single_animation != "" or hold_animation != "") and not force:
		return

	if current_animation != animation_name or force:
		current_animation = animation_name
		outfit.play(animation_name)

	outfit.speed_scale = speed_scale * 0.8
