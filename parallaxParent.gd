extends Node2D
class_name ParallaxParent

var children: Array[ParallaxChild] = []
@export var speed: float = 1
@export_range(-1.0, 1.0) var rotationFactor: float = 0
@export var rotationMultiplier: float = 1.0
@export_range(0.0, 1.0) var rotationPivot: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	for child in get_children():
		if child is ParallaxChild:
			children.append(child)

func _process(_delta: float) -> void:
	rotationMultiplier = sin(Time.get_ticks_msec() / 10000.0)*0.5
