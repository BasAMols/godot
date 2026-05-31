extends Parallax2D
class_name ParallaxChild

var parent: ParallaxParent = null

var speed: float = 1
@export var wind: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent = get_parent()
	speed = autoscroll.x / 200
	scroll_scale.x = speed if speed != 0 else 1.0
	scroll_scale.y = speed * 0.2 + 0.8
	follow_viewport = true
	ignore_camera_scroll = false
	repeat_times = 16

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var rot: float = clamp(parent.rotationFactor, -1.0, 1.0)

	# Geometric turn model: the camera follows a circular path of radius ~1/pivot
	# around a center at the depth corresponding to `rotationPivot`. The rotation
	# contribution is a uniform pixel shift across all layers (true rotation has
	# no per-depth angular shift; depth dependence already lives in `directSpeed`).
	# At rot=+1 with multiplier=1, the layer whose `speed == pivot` is exactly
	# static (rotation cancels its baseline motion); layers closer move right,
	# layers farther move left. At rot=-1, the pivot is "behind the camera" and
	# every layer shifts in the same direction (none can move left). Standing
	# still (parent.speed = 0) zeroes the effect.
	var directSpeed: float = parent.speed * speed
	var rotationSpeed: float = -rot * parent.speed * parent.rotationPivot * parent.rotationMultiplier

	autoscroll.x = directSpeed + rotationSpeed + wind
